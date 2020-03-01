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
    private var viewModel: ProductListViewModel?
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ProductListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfSections
        }
        return Constants.defaultSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.products.count
        }
        return Constants.defaultRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }

        let product = viewModel.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.defaultCellId,
                                                 for: indexPath)
        cell.textLabel?.text = product.name
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProductListViewController: ProductListViewDelegate {
    func updateView(with model: ProductListViewModel) {
        viewModel = model
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

private extension ProductListViewController {
    enum Constants {
        static let defaultSections = 0
        static let defaultRows = 0
        static let defaultCellId = "ListCell"
    }

    func setup() {
        title = presenter?.titleView
        presenter?.loadItems()
        setupView()
    }

    func setupView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.defaultCellId)
    }

    func reloadData() {
        tableView.reloadData()
    }
}
