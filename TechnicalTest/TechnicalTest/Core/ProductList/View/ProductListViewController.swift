//
//  ProductListViewController.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductListViewController: ProductListViewDelegate {
}
