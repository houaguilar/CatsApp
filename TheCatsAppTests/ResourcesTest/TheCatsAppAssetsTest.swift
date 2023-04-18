//
//  CabifyAssetsTest.swift
//  TheCatsAppTests
//
//  Created by Jordy Aguilar on 15/04/23.
//

import XCTest
@testable import TheCatsApp
final class TheCatsAppAssetsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogoNotNil() throws {
        let logo = Asset.SplashView.cabifyLogo.image
        XCTAssertNotNil(logo)
    }
    func testShoppingBagNotNil() throws {
        let logo = Asset.SplashView.shoppingBag.image
        XCTAssertNotNil(logo)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
