//
//  ProductListDataProviderMock.swift
//  TechnicalTestTests
//
//  Created by Alan Roldán Maillo on 03/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductListDataProviderMock: ProductListDataProvider {
    func request(_ request: ProductListRequest, success: @escaping Success, failure: @escaping Failure) {
        let product = Product(id: 0,
                              name: "Vikings",
                              summary: "Lorem ipsum dolor sit amet",
                              imageUrl: Product.ImageURL(medium: "image",
                                                         original: "image"),
                              rating: 5,
                              genres: ["Drama", "Action"])

        switch request.page {
        case 0, 1:
            let products = Products(list: [product])
            success(products)
        default:
            failure(.invalidUrl)
        }
    }
}
