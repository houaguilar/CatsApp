//
//  ConfigurationProductsAPI.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//
import Foundation
extension Configuration {
    static var TheCatsAPI: [String: Any] {
        let path = Bundle.main.path(forResource: "CatsConfigurations", ofType: "plist")
        let url = URL.init(fileURLWithPath: path!)
        do {
            guard let data = try? Foundation.Data(contentsOf: url),
                  let result = try PropertyListSerialization.propertyList(
                    from: data,
                    options: [],
                    format: nil
                  ) as? [String: Any] else {
                return [:]
            }
            return result
        } catch {
            return [:]
        }
    }
    // MARK: Scheme and host
    private func getURLBaseHomeMeliAPI() -> String {
        if let scheme: String = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "scheme",
            baseConfigurationDictionary: Configuration.TheCatsAPI) as? String {
            self.scheme = scheme
        }
        if let basePath: String = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "host",
            baseConfigurationDictionary: Configuration.TheCatsAPI) as? String {
            self.basePath = basePath
        }
        return self.scheme + self.basePath
    }
    // MARK: Base Urls
    private static var baseCatsProduct: String? {
        let configuration = Configuration()
        let urlBase = configuration.getURLBaseHomeMeliAPI()

        let basePathAuth = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "baseProducts",
            baseConfigurationDictionary: Configuration.TheCatsAPI
        ) as? String

        return urlBase + basePathAuth!
    }

    // MARK: Main Urls
    static var urlStackExchange: String {
        guard let url = baseCatsProduct else {
            fatalError("the url should exist")
        }
        return url
    }
}
