//
//  ReachabilityManager.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 16/03/23.
//

import Foundation
import Reachability

public protocol ReachabilityCheckingProtocol {
    /// isConnectedToNetwork public function
    func isConnectedToNetwork() -> Bool
}
// MARK: - Delegate Protocol

public protocol ConnectionListener: AnyObject {
    func connectionChanged(status: Reachability.Connection)
}

// MARK: - Delegating Object

public class ReachabilityManager {

    private init() {}

    public static let shared = ReachabilityManager()

    let multicastDelegate = MulticastDelegate<ConnectionListener>()

    var reachability : Reachability? = nil
    @objc func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        multicastDelegate.invokeDelegates{ listener in
            DispatchQueue.main.async {
                listener.connectionChanged(status: reachability.connection)
            }
        }
    }

    public func startMonitoring() {

        do {
            self.reachability = try Reachability()
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.reachabilityChanged),
                                                   name: Notification.Name.reachabilityChanged,
                                                   object: self.reachability)
            try self.reachability?.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }

    public func stopMonitoring() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }

    public func addListener(listener: ConnectionListener) {
        multicastDelegate.addDelegate(listener)
    }

    public func removeListener(listener: ConnectionListener) {
        multicastDelegate.removeDelegate(listener)
    }

    public func isReachable(success: @escaping (() -> Void) = {},
                            failure: @escaping (() -> Void) = {}) {
        DispatchQueue.main.async {
            (self.reachability?.connection != .unavailable) ? success() : failure()
        }
    }

}
