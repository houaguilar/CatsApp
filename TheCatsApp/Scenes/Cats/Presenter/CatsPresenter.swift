//
//  CatsPresenter.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
protocol ListCatsPresentationLogic {
    func presentListProducts(products: DisplayProducts)
}
final class CatsPresenter: ShowAlertPresentationLogic, ListCatsPresentationLogic {
    weak var viewController: CatsDisplayLogic?
    func presentListProducts(products: DisplayProducts) {
        let viewModel = ListProducts.Products.ViewModel(displayedProducts: products)
        viewController?.displayCats(viewModel)
    }
    func presentError(error: MessageError) {
        viewController?.displayError(error: error)
    }
}
