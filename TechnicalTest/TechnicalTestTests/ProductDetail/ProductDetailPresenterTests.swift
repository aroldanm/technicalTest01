//
//  ProductDetailPresenterTests.swift
//  TechnicalTestTests
//
//  Created by Alan Roldán Maillo on 02/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import XCTest

class ProductDetailPresenterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadData() {
        let product = Product(id: 0,
                              name: "Vikings",
                              summary: "Lorem ipsum dolor sit amet",
                              imageUrl: Product.ImageURL(medium: "image",
                                                         original: "image"),
                              rating: 5,
                              genres: ["Drama", "Action"])

        let presenter = ProductDetailPresenterImpl(product: product)
        let viewModel = presenter.loadData()

        XCTAssertTrue(viewModel.title == product.name)
        XCTAssertTrue(viewModel.summary == product.summary)
        XCTAssertTrue(viewModel.image == product.imageUrl.original)
        XCTAssertTrue(viewModel.preview == product.imageUrl.medium)
        XCTAssertTrue(viewModel.rating == product.rating)
        XCTAssertTrue(viewModel.genres == "Drama • Action")
    }
}
