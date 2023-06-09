//
//  CabifyNetworkLogger.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import Alamofire
import UIKit
class CatsNetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.cabify.app.networklogger")
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    func request<Value>(_ request: DataRequest,
                        didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
