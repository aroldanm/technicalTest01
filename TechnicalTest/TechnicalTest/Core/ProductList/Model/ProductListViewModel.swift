//
//  ProductListViewModel.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

struct ProductListViewModel {
    var items: [ProductListCellViewModel]
    var shouldPaginate: Bool
    var numberOfSections: Int
}
