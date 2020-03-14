//
//  ProductListDataProviderImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class ProductListDataProviderImpl: ProductListDataProvider {
    func request(_ productRequest: ProductListRequest, success: @escaping Success, failure: @escaping Failure) {
        let request = Request(url: Constants.url,
                              method: Constants.method,
                              params: [Constants.Key.page: productRequest.page])
        Network.request(request, success: { data in
            do {
                let response = try ProductListResponse(data: data)
                success(ProductListAdapter.toDomain(from: response))
            } catch {
                failure(.invalidResponse(error))
            }
        }, failure: failure)
    }
}

private extension ProductListDataProviderImpl {
    enum Constants {
        static let method = Method.get
        static let url = "http://api.tvmaze.com/shows"

        enum Key {
            static let page = "page"
        }
    }
}
