//
//  AplicationCoordinator.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var navigation: UINavigationController
    let window: UIWindow?

    var homeCoordinator: SplashCoordinator
    init(window: UIWindow) {
        self.window = window
        navigation = UINavigationController()
        navigation.navigationBar.isHidden = true
        homeCoordinator = SplashCoordinator(navigation)
    }
    func start() {
        window?.rootViewController = navigation
        homeCoordinator.start()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
