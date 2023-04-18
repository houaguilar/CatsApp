//
//  Coordinator.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get set }
//    var children: [Coordinator] { get set }
    func start()
}
