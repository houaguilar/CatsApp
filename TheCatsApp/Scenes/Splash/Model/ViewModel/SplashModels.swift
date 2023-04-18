//
//  SplashViewModel.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import UIKit

typealias DisplayProduct = ListProducts.Products.ViewModel.ProductModel
typealias DisplayProducts = [DisplayProduct]

enum ListProducts {
    // MARK: Use cases
    enum Products {
        struct Request {
        }
        struct Response {
            var products: [Cat]
        }
        struct ViewModel {
            class ProductModel {
                private(set) var referenceImageID:String
                private(set) var name:String
                private(set) var origin:String
                private(set) var intelligence:Int
                private(set) var identifier:String
                private(set) var image: String = String()
                init(name: String, identifier: String, origin:String, intelligence: Int, referenceImageID: String) {
                    self.name = name
                    self.identifier = identifier
                    self.origin = origin
                    self.intelligence = intelligence
                    self.referenceImageID = referenceImageID
                    self.image = self.getUrlImage(referenceImageID)
                }
                func getUrlImage(_ category: String) -> String {
                    var image = "https://cdn2.thecatapi.com/images/\(referenceImageID).jpg"
                    return image
                }
            }
            var displayedProducts: DisplayProducts = DisplayProducts()
        }
    }
}

