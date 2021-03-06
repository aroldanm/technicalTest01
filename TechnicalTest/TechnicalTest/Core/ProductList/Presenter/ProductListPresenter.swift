//
//  ProductListPresenter.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

protocol ProductListPresenter {
    var titleView: String { get }
    var emptyLabel: String { get }
    var loadingLabel: String { get }

    func loadItems()
    func loadMoreItems()
    func select(item: ProductListCellViewModel)
}
