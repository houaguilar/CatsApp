//
//  SplashInteractor.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit
protocol ListProductsBusinessLogic {
    func fetchListProducts(request: ListProducts.Products.Request)
}
class SplashInteractor: ListProductsBusinessLogic {
    var presenter: SplashPresenter?
    func fetchListProducts(request: ListProducts.Products.Request) {
        let worker = ListCatWorker()
        worker.getListProductsUI({ listProducts, error in
            if let error = error {
                self.presenter?.presentError(error: error)
            } else {
                guard let products = listProducts else {
                    return
                }
                let response = ListProducts.Products.Response(products: products)
                self.presenter?.presentListProducts(response: response)
            }
        })
    }
}
