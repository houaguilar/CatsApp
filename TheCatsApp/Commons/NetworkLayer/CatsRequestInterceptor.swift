//
//  CabifyRequestInterceptor.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import Alamofire

class CatsRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Content-Type", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("API-KEY", forHTTPHeaderField: "bda53789-d59e-46cd-9bc4-2936630fde39")
        completion(.success(urlRequest))
    }
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        if let statusCode = response?.statusCode, (500...599).contains(statusCode), request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
            return completion(.doNotRetry)
        }
    }
}
