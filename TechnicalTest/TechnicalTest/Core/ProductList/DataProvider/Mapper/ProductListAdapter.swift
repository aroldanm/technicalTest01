//
//  ProductListAdapter.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductListAdapter {
    static func toDomain(from response: ProductListResponse) -> Products {
        var productList = Products()
        if let list = response.list {
            list.forEach { item in
                if let product = toProduct(from: item) {
                    productList.append(product)
                }
            }
        }
        return productList
    }
}

private extension ProductListAdapter {
    static func toProduct(from item: ProductEntity) -> Product? {
        guard let id = item.id ,
            let name = item.name,
            let summary = item.summary,
            let imageMedium = item.image?.medium,
            let genresItems = item.genres,
            let imageOriginal = item.image?.original else {
                return nil
        }
        let genres = genresItems.joined(separator: " • ")
        let normalizedRating = (item.rating?.average ?? 0) * 5.0 / 10.0
        return Product(id: id,
                       name: name,
                       summary: summary,
                       imageUrl: Product.ImageURL(medium: imageMedium,
                                                  original: imageOriginal),
                       rating: normalizedRating,
                       genres: genres)
    }
}
