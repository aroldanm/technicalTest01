//
//  Products.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

struct Products {
    private(set) var list = [Product]()

    mutating func append(_ product: Product) {
        list.append(product)
    }
}
