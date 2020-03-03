//
//  ProductListInteractorImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductListInteractorImpl {
    private let dataProvider: ProductListDataProvider
    let shouldPaginate = true

    init(dataProvider: ProductListDataProvider) {
        self.dataProvider = dataProvider
    }
}

extension ProductListInteractorImpl: ProductListInteractor {
    func loadProducts(success: @escaping Success, failure: Failure?) {
        loadMoreProducts(from: Products(), success: success, failure: failure)
    }

    func loadMoreProducts(from current: Products, success: @escaping Success, failure: Failure?) {
        let lastProductId = current.list.last?.id ?? Constants.defaultProductId
        let page = lastProductId != 0 ? Int(lastProductId/Constants.productsBatch)+1 : 0
        requestProducts(page: page, success: { products in
            success(Products(list: (current.list) + products.list))
        }, failure: failure)
    }
}

private extension ProductListInteractorImpl {
    enum Constants {
        static let productsBatch = 250
        static let defaultPage = 0
        static let defaultProductId = 0
    }
    
    func requestProducts(page: Int = Constants.defaultPage,
                         success: @escaping Success, failure: Failure?) {
        let request = ProductListRequest(page: page)
        dataProvider.request(request, success: success) { error in
            failure?(error)
        }
    }
}
