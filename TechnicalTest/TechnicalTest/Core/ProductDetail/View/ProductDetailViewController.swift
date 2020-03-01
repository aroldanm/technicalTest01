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
        reloadData()
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func updateView(with model: ProductDetailViewModel) {
        viewModel = model
        DispatchQueue.main.async {
            self.setupView()
        }
    }
}

private extension ProductDetailViewController {
    func reloadData() {
        presenter?.loadData()
    }

    func setupView() {
        guard let viewModel = viewModel else {
            return
        }
    }
}
