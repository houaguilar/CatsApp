//
//  SplashPresenter.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit
protocol ListProductsPresentationLogic {
    func presentListProducts(response: ListProducts.Products.Response)
}
protocol ShowAlertPresentationLogic {
    func presentError(error: MessageError)
}
final class SplashPresenter: ListProductsPresentationLogic, ShowAlertPresentationLogic {
    weak var viewController: ListProductsDisplayLogic?
    func presentListProducts(response: ListProducts.Products.Response) {
        var displayedProducts: DisplayProducts = []
        displayedProducts = response.products.map({ $0.toProductModel() })
        let viewModel = ListProducts.Products.ViewModel(displayedProducts: displayedProducts)
        viewController?.displayFetchedProducts(viewModel: viewModel)
    }
    func presentError(error: MessageError) {
        viewController?.displayError(error: error)
    }
}
