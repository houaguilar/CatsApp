//
//  SplashCoordinator.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import UIKit
protocol ListCatsCoordinatorLogic: AnyObject {
    func goToCats(products: [ListProducts.Products.ViewModel.ProductModel])
}
class SplashCoordinator: Coordinator {
    var navigation: UINavigationController
    private weak var splashViewController: SplashViewController?
    static let storyboardName = "Main"

    init(_ navigation: UINavigationController) {
        self.navigation = navigation
    }
    func start() {
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let splashViewController = SplashViewController(interactor,
                                                        presenter)
        splashViewController.coordinator = self
        navigation.pushViewController(splashViewController, animated: false)
        self.splashViewController = splashViewController
    }
}
extension SplashCoordinator: ListCatsCoordinatorLogic {

    func goToCats(products: [ListProducts.Products.ViewModel.ProductModel]) {
        let coordinator = CatsCoordinator(navigation, products)
        coordinator.start()
    }
}
