//
//  ProductsAPI.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Alamofire
import Foundation

typealias Cats = [Cat]
protocol CatsAPIProtocol {
    func getListProducts(handler: @escaping (Cats?, ServerError?) -> Void )
}
class CatsAPI: CatsAPIProtocol {
    func getListProducts(handler: @escaping (Cats?, ServerError?) -> Void) {
        let queue = DispatchQueue(label: "com.queue.concurrent",
                                  qos: .userInteractive,
                                  attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        queue.async {
            let apiManager = CatsApiManager.shared.sessionManager
            let urlRequest = URL(string: Configuration.urlStackExchange)!
            apiManager.request(urlRequest,
                               method: .get)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Cats.self,
                                   queue: queue) { response in
                    guard let stackExchange = response.value else {
                        semaphore.signal()
                        DispatchQueue.main.async {
                            let code = response.response?.statusCode
                            if code == 401 {
                                let serverError = ServerError(rawValue: code!)
                                handler(nil, serverError)
                            }
                        }
                        return
                    }
                    semaphore.signal()
                    DispatchQueue.main.async {
                        handler(stackExchange, nil)
                    }
                }
            semaphore.wait()
        }
    }
}
