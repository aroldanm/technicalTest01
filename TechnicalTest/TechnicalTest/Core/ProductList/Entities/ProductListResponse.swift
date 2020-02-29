//
//  ProductListResponse.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

struct ProductListResponse {
    var list: [ProductEntity]?

    init(data: Data) throws {
        list = try JSONDecoder().decode(Array<ProductEntity>.self, from: data)
    }
}
