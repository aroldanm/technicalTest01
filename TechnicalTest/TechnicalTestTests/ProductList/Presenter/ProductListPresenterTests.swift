//
//  ProductListPresenterTests.swift
//  TechnicalTestTests
//
//  Created by Alan Roldán Maillo on 03/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import XCTest

class ProductListPresenterTests: XCTestCase {
    var presenter: ProductListPresenter {
        let router = ProductListRouterImpl()
        let view = ViewTest()
        let dataProvider = ProductListDataProviderMock()
        let interactor = ProductListInteractorImpl(dataProvider: dataProvider)
        return ProductListPresenterImpl(interactor: interactor, router: router, view: view)
    }
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadItems() {
        presenter.loadItems()
    }

    func testLoadMoreItems() {
        presenter.loadMoreItems()
    }
}

class ViewTest: UIViewController, ProductListView {
    func updateView(with model: ProductListViewModel) {
        XCTAssertTrue(model.numberOfSections == 2)
        XCTAssertTrue(model.shouldPaginate)
        XCTAssertNotNil(model.products)
        XCTAssertFalse(model.products.isEmpty)
        XCTAssertTrue(model.products.count == 1)
        XCTAssertTrue(model.products.first?.name == "Vikings")
        XCTAssertTrue(model.products.first?.id == 0)
        XCTAssertTrue(model.products.first?.genres == ["Drama", "Action"])
    }
}
