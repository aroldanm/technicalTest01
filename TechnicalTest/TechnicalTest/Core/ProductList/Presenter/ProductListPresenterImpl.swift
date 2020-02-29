//
//  ProductListPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductListPresenterImpl {
    private weak var delegate: ProductListViewDelegate?
    private let interactor: ProductListInteractor
    private let router: ProductListRouter

    init(interactor: ProductListInteractor, router: ProductListRouter, delegate: ProductListViewDelegate? = nil) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

extension ProductListPresenterImpl: ProductListPresenter {
}
