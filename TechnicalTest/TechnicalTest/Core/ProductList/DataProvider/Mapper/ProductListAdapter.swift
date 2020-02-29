//
//  ProductListAdapter.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

protocol ProductListAdapter {
    func toDomain(from response: ProductListResponse) -> Products
}
