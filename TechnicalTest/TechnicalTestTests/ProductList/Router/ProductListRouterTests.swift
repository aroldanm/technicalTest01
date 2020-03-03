//
//  ProductListRouterTests.swift
//  TechnicalTestTests
//
//  Created by Alan Roldán Maillo on 03/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import XCTest

class ProductListRouterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNavigateToDetail() {
        let product = Product(id: 0,
                              name: "Vikings",
                              summary: "Lorem ipsum dolor sit amet",
                              imageUrl: Product.ImageURL(medium: "image",
                                                         original: "image"),
                              rating: 5,
                              genres: ["Drama", "Action"])

        let viewController: UIViewController = UIApplication.shared.windows.first!.rootViewController!
        let router = ProductListRouterImpl()
        router.navigateToDetail(with: product, from: viewController)
        
        XCTAssertTrue(viewController.presentedViewController is ProductDetailViewController)
    }
}
