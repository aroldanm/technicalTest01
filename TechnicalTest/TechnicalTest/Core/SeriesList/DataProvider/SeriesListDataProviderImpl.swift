//
//  SeriesListDataProviderImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class SeriesListDataProviderImpl: SeriesListDataProvider {
    func request(_ request: SeriesListRequest, success: @escaping Success, failure: @escaping Failure) {
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

private extension SeriesListDataProviderImpl {
    enum Constants {
        static let method = "GET"
        static let baseUrl = "http://api.tvmaze.com/shows"
        static let varUrl = "?page="
    }

    func configurePath(index: Int) -> String {
        return Constants.baseUrl+Constants.varUrl+String(index)
    }

    func doTask(_ request: URLRequest, success: @escaping Success, failure: @escaping Failure) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let response = try SeriesListResponse(data: data)
                success(response)
            } catch {
                failure(.invalidResponse(error))
            }
        }
        task.resume()
    }
}
