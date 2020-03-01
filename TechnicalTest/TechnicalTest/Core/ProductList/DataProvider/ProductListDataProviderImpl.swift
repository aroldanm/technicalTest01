//
//  ProductListDataProviderImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class ProductListDataProviderImpl: ProductListDataProvider {
    func request(_ request: ProductListRequest, success: @escaping Success, failure: @escaping Failure) {
        let pathUrl = configurePath(index: request.page)
        guard let url = URL(string: pathUrl) else {
            failure(.invalidUrl)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.method
        doTask(urlRequest, success: success, failure: failure)
    }
}

private extension ProductListDataProviderImpl {
    enum Constants {
        static let method = "GET"
        static let baseUrl = "http://api.tvmaze.com/shows"
        static let varUrl = "?page="
    }

    func configurePath(index: Int) -> String {
        return Constants.baseUrl+Constants.varUrl+String(index)
    }

    func doTask(_ request: URLRequest, success: @escaping Success, failure: @escaping Failure) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data,
                error == nil else {
                    failure(.unknown(error))
                    return
            }

            if let httpStatus = response as? HTTPURLResponse,
                httpStatus.statusCode != 200 {
                failure(.httpError(httpStatus.statusCode, response))
                return
            }

            do {
                let response = try ProductListResponse(data: data)
                success(ProductListAdapter.toDomain(from: response))
            } catch {
                failure(.invalidResponse(error))
            }
        }
        task.resume()
    }
}
