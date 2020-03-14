//
//  ProductListDataProvider.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

protocol ProductListDataProvider {
    typealias Success = (Products) -> Void
    typealias Failure = (RequestError) -> Void

    func request(_ productRequest: ProductListRequest, success: @escaping Success, failure: @escaping Failure)
}
