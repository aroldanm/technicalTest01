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
    private var fetchingMore = false
    private var shouldfetchMore: Bool {
        if let viewModel = viewModel {
            return viewModel.shouldPaginate &&
                !fetchingMore &&
                !viewModel.products.isEmpty
        }
        return false
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.contentInset.top = 10
            tableView.backgroundView = emptyView
            registerCells()
        }
    }

    private var emptyView: UIView {
        createEmptyView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > 0,
            offsetY > contentHeight - height,
            shouldfetchMore {
            beginBatchFetch()
        }
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
            if section == viewModel.numberOfSections - 1, shouldfetchMore {
                return Constants.indicatorSections
            }
            return viewModel.products.count
        }
        return Constants.defaultRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = viewModel {
            if indexPath.section == viewModel.numberOfSections - 1,
                let cell = tableView.dequeueReusableCell(withIdentifier: ActivityIndicatorCell.identifier, for: indexPath) as? ActivityIndicatorCell {
                cell.startAnimating()
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.identifier, for: indexPath) as? ProductListCell {
                let product = viewModel.products[indexPath.row]
                let model = ProductListCellViewModel(name: product.name,
                                                     image: product.imageUrl.medium ?? "")
                cell.populateCell(model: model)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = viewModel {
            let product = viewModel.products[indexPath.row]
            presenter?.select(item: product)
        }
    }
}

extension ProductListViewController: ProductListView {
    func updateView(with model: ProductListViewModel) {
        viewModel = model
        fetchingMore = false
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

private extension ProductListViewController {
    enum Constants {
        static let defaultSections = 0
        static let indicatorSections = 1
        static let defaultRows = 0
    }

    func setup() {
        title = presenter?.titleView
        presenter?.loadItems()
    }

    func createEmptyView() -> UIView {
        let container = UIView(frame: tableView.frame)

        var posY: CGFloat = 0
        var message = ""
        if let viewModel = viewModel {
            message = presenter?.emptyLabel ?? ""
            var image: UIImageView {
                let image = UIImageView(image: UIImage(systemName: "cloud"))
                image.frame.size = CGSize(width: 90, height: 90)
                image.tintColor = .label
                image.center = container.center
                image.frame.origin.y -= 10
                image.contentMode = .scaleAspectFit
                return image
            }
            container.addSubview(image)
            posY = image.frame.origin.y + image.frame.size.height + 5
        } else {
            message = presenter?.loadingLabel ?? ""
            var indicator: UIActivityIndicatorView {
                let indicator = UIActivityIndicatorView()
                indicator.startAnimating()
                indicator.center = container.center
                indicator.frame.origin.y -= 10
                return indicator
            }
            container.addSubview(indicator)
            posY = indicator.frame.origin.y + indicator.frame.size.height + 15
        }

        var label: UILabel {
            let label = UILabel()
            label.text = message
            label.textAlignment = .center
            label.numberOfLines = 0
            label.frame.size.width = container.frame.size.width*0.6
            label.frame.origin.y = posY
            label.sizeToFit()
            label.center.x = container.center.x
            return label
        }
        container.addSubview(label)

        return container
    }

    func registerCells() {
        let productListCell = UINib.init(nibName: ProductListCell.identifier,
                                         bundle: nil)
        tableView.register(productListCell,
                           forCellReuseIdentifier: ProductListCell.identifier)

        let activityIndicatorCell = UINib.init(nibName: ActivityIndicatorCell.identifier,
                                               bundle: nil)
        tableView.register(activityIndicatorCell,
                           forCellReuseIdentifier: ActivityIndicatorCell.identifier)
    }

    func reloadData() {
        if let viewModel = viewModel,
            !viewModel.products.isEmpty {
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = emptyView
        }
        tableView.reloadData()
    }

    func beginBatchFetch() {
        fetchingMore = true
        presenter?.loadMoreItems()
    }
}
