//
//  ProductDetailPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductDetailPresenterImpl {
    typealias View = (UIViewController & ProductDetailView)
    private let product: Product
    private weak var view: ProductDetailView?

    init(product: Product, view: ProductDetailView? = nil) {
        self.product = product
        self.view = view
    }
}

extension ProductDetailPresenterImpl: ProductDetailPresenter {
    func loadData() -> ProductDetailViewModel {
        return makeViewModel()
    }
}

private extension ProductDetailPresenterImpl {
    func makeViewModel() -> ProductDetailViewModel {
        let genres = product.genres.joined(separator: " • ")
        return ProductDetailViewModel(title: product.name,
                                      summary: product.summary,
                                      image: product.imageUrl.original ?? "",
                                      preview: product.imageUrl.medium ?? "",
                                      rating: product.rating,
                                      genres: genres)
    }
}
