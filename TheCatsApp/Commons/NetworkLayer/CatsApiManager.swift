//
//  CatsApiManager.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import Foundation
import Alamofire

class CatsApiManager: NSObject {
    static let shared = CatsApiManager()
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        let networkLogger = CatsNetworkLogger()
        let interceptor = CatsRequestInterceptor()
        return Session(configuration: configuration,
                       interceptor: interceptor,
                       cachedResponseHandler: responseCacher,
                       eventMonitors: [networkLogger])
    }()
}
