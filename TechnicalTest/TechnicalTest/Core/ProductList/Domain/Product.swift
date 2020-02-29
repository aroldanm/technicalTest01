//
//  Product.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

struct Product {
    private(set) var id: Int
    private(set) var name: String
    private(set) var summary: String
    private(set) var imageUrl: ImageURL
    private(set) var rating: Float

    struct ImageURL {
        var medium: String?
        var original: String?
    }
}
