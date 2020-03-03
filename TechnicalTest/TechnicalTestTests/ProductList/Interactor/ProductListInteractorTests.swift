//
//  ProductListInteractorTests.swift
//  TechnicalTestTests
//
//  Created by Alan Roldán Maillo on 03/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import XCTest

class ProductListInteractorTests: XCTestCase {
    var interactor: ProductListInteractor?

    override func setUp() {
        super.setUp()
        let dataProvider = ProductListDataProviderMock()
        interactor = ProductListInteractorImpl(dataProvider: dataProvider)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadProducts() {
        guard let interactor = interactor else {
            return
        }
        interactor.loadProducts(success: { products in
            XCTAssertNotNil(products)
            XCTAssertFalse(products.list.isEmpty)
            XCTAssertTrue(products.list.count == 1)
            XCTAssertTrue(products.list.first?.name == "Vikings")
            XCTAssertTrue(products.list.first?.id == 0)
            XCTAssertTrue(products.list.first?.genres == ["Drama", "Action"])
        }, failure: { error in
            XCTAssertNil(error)
        })
    }

    func testLoadMoreProducts() {
        guard let interactor = interactor else {
            return
        }

        let product = Product(id: 43,
                              name: "Arrow",
                              summary: "Lorem ipsum dolor sit amet",
                              imageUrl: Product.ImageURL(medium: "image",
                                                         original: "image"),
                              rating: 5,
                              genres: ["Sciencie-Fiction"])
        let productList = Products(list: [product])
        
        interactor.loadMoreProducts(from: productList, success: { products in
            XCTAssertNotNil(products)
            XCTAssertFalse(products.list.isEmpty)
            XCTAssertTrue(products.list.count == 2)
            XCTAssertTrue(products.list[0].name == "Arrow")
            XCTAssertTrue(products.list[1].name == "Vikings")
            XCTAssertTrue(products.list[0].id == 43)
            XCTAssertTrue(products.list[1].id == 0)
            XCTAssertTrue(products.list[0].genres == ["Sciencie-Fiction"])
            XCTAssertTrue(products.list[1].genres == ["Drama", "Action"])
        }) { error in
            XCTAssertNil(error)
        }

        interactor.loadMoreProducts(from: productList, success: { _ in
        }, failure: { error in
            XCTAssertNotNil(error)
        })
    }
}
