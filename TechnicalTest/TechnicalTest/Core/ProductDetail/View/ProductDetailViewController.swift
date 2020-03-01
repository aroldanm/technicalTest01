//
//  ProductDetailViewController.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenter?
    private var viewModel: ProductDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
}
