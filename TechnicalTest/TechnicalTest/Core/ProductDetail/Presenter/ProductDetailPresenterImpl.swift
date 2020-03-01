//
//  ProductDetailPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductDetailPresenterImpl {
    private let product: Product
    private weak var delegate: ProductDetailViewDelegate?

    init(product: Product, delegate: ProductDetailViewDelegate? = nil) {
        self.product = product
        self.delegate = delegate
    }
}

extension ProductDetailPresenterImpl: ProductDetailPresenter {
    func loadData() {
        let viewModel = makeViewModel()
        delegate?.updateView(with: viewModel)
    }
}

private extension ProductDetailPresenterImpl {
    func makeViewModel() -> ProductDetailViewModel {
        return ProductDetailViewModel(title: product.name,
                                      summary: product.summary,
                                      image: product.imageUrl.original ?? "",
                                      rating: product.rating)
    }
}
