//
//  ProductListPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class ProductListPresenterImpl {
    private let interactor: ProductListInteractor
    private let router: ProductListRouter
    private weak var delegate: ProductListViewDelegate?
    private var products: Products?

    private(set) var titleView = NSLocalizedString("ProductList.title", comment: "title")
    private(set) var emptyLabel = NSLocalizedString("ProductList.emptyLabel", comment: "empty")
    private(set) var loadingLabel = NSLocalizedString("ProductList.gettingData", comment: "loading")

    init(interactor: ProductListInteractor, router: ProductListRouter, delegate: ProductListViewDelegate? = nil) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

extension ProductListPresenterImpl: ProductListPresenter {
    func loadItems() {
        interactor.loadProducts(success: { products in
            self.update(with: products)
        }, failure: { _ in
            self.update()
        })
    }

    func loadMoreItems() {
        if let products = products {
            interactor.loadMoreProducts(from: products,
                                        success: { products in
                                            self.update(with: products)
            }, failure: nil)
        } else {
            loadItems()
        }
    }
}

private extension ProductListPresenterImpl {
    func update(with products: Products? = nil) {
        if let products = products {
            self.products = products
        }
        let viewModel = makeViewModel()
        delegate?.updateView(with: viewModel)
    }

    func makeViewModel() -> ProductListViewModel {
        let products = self.products?.list ?? Products().list
        return ProductListViewModel(products: products,
                                    shouldPaginate: interactor.shouldPaginate,
                                    numberOfSections: interactor.shouldPaginate ? 2 : 1)
    }
}
