//
//  GetProductListWorker.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//
import Foundation
import UIKit

protocol ListCatWorkerProtocol {
    func getListProductsUI(_ handler: @escaping (Cats?, MessageError?) -> Void )
}
class ListCatWorker: ListCatWorkerProtocol {
    let api: CatsAPIProtocol
    var reachability: ReachabilityCheckingProtocol
    let maxNumberOfAttempts = 3
    var currentNumberOfAttempts = 0
    init(
        _ api: CatsAPIProtocol = CatsAPI(),
        _ reachability: ReachabilityCheckingProtocol = LocalReachability()
    ) {
        self.api = api
        self.reachability = reachability
    }
    func getListProductsUI(_ handler: @escaping (Cats?, MessageError?) -> Void ) {
        guard reachability.isConnectedToNetwork() && currentNumberOfAttempts != maxNumberOfAttempts else {
            handler(nil, MessageError(serverError: .nointernet))
            return
        }
        api.getListProducts(handler: { products, error in
            if let error = error {
                debugPrint(error)
                self.getListProductsUI(handler)
                let messageError = MessageError(serverError: error)
                handler(nil,messageError)
            }
            guard let listProducts = products else {
                return
            }
            handler(listProducts, nil)
        })
    }
}
