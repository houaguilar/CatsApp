//
//  MessageError.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import UIKit
enum ServerError: Int {
    case unacceptable = 401
    case nointernet = 0
  // Throw in all other cases
    case unexpected = -1
}
struct MessageError {
    let title: String
    let message: String
    private(set) var currentError: ServerError
    init(serverError: ServerError) {
        currentError = serverError
        switch currentError {
        case .unacceptable:
            title = "Credenciles"
            message = "Las credenciales son incorrectas intentelo mas tarde."
        case .nointernet:
            title = "Internet"
            message = "El dispoasitivo no cuenta con conexion."
        default:
            title = "Ha ocurrido un error."
            message = "Intentelo mas tarde"
        }
    }
}
