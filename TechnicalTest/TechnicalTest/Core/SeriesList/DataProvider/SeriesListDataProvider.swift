//
//  SeriesListDataProvider.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

protocol SeriesListDataProvider {
    typealias Success = (SeriesListResponse) -> Void
    typealias Failure = (RequestError) -> Void

    func request(_ request: SeriesListRequest, success: @escaping Success, failure: @escaping Failure)
}

enum RequestError: Error {
    case invalidUrl
    case httpError(Int, URLResponse?)
    case invalidResponse(Error?)
    case unknown(Error?)
}
