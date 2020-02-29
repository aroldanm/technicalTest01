//
//  ProductListAdapter.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class ProductListAdapter {
    class func toDomain(from response: ProductListResponse) -> SeriesList {
        var seriesList = SeriesList()
        if let list = response.list {
            list.forEach { item in
                if let serie = toSerie(from: item) {
                    seriesList.append(serie)
                }
            }
        }
        return seriesList
    }
}

private extension ProductListAdapter {
    class func toSerie(from item: SeriesItem) -> Serie? {
        guard let id = item.id ,
            let name = item.name,
            let summary = item.summary,
            let imageMedium = item.image?.medium,
            let imageOriginal = item.image?.original else {
                return nil
        }
        return Serie(id: id,
                     name: name,
                     summary: summary,
                     imageUrl: Serie.ImageURL(medium: imageMedium,
                                              original: imageOriginal),
                     rating: item.rating?.average ?? 0)
    }
}
