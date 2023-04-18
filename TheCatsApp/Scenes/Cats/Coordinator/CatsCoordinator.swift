//
//  CatsCoordinator.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import UIKit

protocol ShowCoordinatorLogic: AnyObject {
    func showCats(product: DisplayProduct)
}
class CatsCoordinator: Coordinator {
    var navigation: UINavigationController
    private weak var CatsViewController: CatsViewController?
    static let storyboardName = "Main"
    private var products: DisplayProducts
    init(_ navigation: UINavigationController,
         _ products: [ListProducts.Products.ViewModel.ProductModel]) {
        self.navigation = navigation
        self.products = products
    }
    func start() {
        let interactor = CatsInteractor(products)
        let presenter = CatsPresenter()
        let CatsViewController = TheCatsApp.CatsViewController(interactor,
                                                        presenter)
        CatsViewController.coordinator = self
        navigation.pushViewController(CatsViewController, animated: false)
        self.CatsViewController = CatsViewController
    }
}
extension CatsCoordinator: ShowCoordinatorLogic {

    func showCats(product: DisplayProduct ) {
    }
}
