//
//  CatsInteractor.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation

final class CatsInteractor {
    var presenter: CatsPresenter?
    private var products: DisplayProducts
    init(_ products: DisplayProducts) {
        self.products = products
    }
    func fetchListProducts() {
        self.presenter?.presentListProducts(products: self.products)
    }
}
