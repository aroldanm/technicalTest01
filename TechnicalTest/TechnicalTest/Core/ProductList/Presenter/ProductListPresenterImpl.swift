//
//  ProductListPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductListPresenterImpl {
    typealias View = (UIViewController & ProductListView)
    private let interactor: ProductListInteractor
    private let router: ProductListRouter
    private weak var view: View?
    private var products: Products?

    private(set) var titleView = NSLocalizedString("ProductList.title", comment: "title")
    private(set) var emptyLabel = NSLocalizedString("ProductList.emptyLabel", comment: "empty")
    private(set) var loadingLabel = NSLocalizedString("ProductList.gettingData", comment: "loading")

    init(interactor: ProductListInteractor, router: ProductListRouter, view: View? = nil) {
        self.interactor = interactor
        self.router = router
        self.view = view
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

    func select(item: ProductListCellViewModel) {
        if let view = view,
            let product = products?.list.first(where: {$0.id == item.id}) {
            router.navigateToDetail(with: product, from: view)
        }
    }
}

private extension ProductListPresenterImpl {
    func update(with products: Products? = nil) {
        if let products = products {
            self.products = products
        }
        let viewModel = makeViewModel()
        view?.updateView(with: viewModel)
    }

    func makeViewModel() -> ProductListViewModel {
        let products = self.products?.list ?? Products().list
        var cellViewModels = [ProductListCellViewModel]()
        products.forEach { product in
            cellViewModels.append(ProductListCellViewModel(id: product.id,
                                                           name: product.name,
                                                           genres: product.genres,
                                                           image: product.imageUrl.medium ?? ""))
        }
        return ProductListViewModel(items: cellViewModels,
                                    shouldPaginate: interactor.shouldPaginate,
                                    numberOfSections: interactor.shouldPaginate ? 2 : 1)
    }
}
