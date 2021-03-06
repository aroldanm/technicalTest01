//
//  ProductListInteractor.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

protocol ProductListInteractor {
    typealias Success = (Products) -> Void
    typealias Failure = (Error) -> Void

    var shouldPaginate: Bool { get }

    func loadProducts(success: @escaping Success, failure: Failure?)
    func loadMoreProducts(from current: Products,
                          success: @escaping Success, failure: Failure?)
}
