//
//  ProductListView.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

protocol ProductListView: AnyObject {
    func updateView(with model: ProductListViewModel)
}
