//
//  ProductListCell.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell, CustomCell {
    static var identifier = "ProductListCell"

    @IBOutlet private weak var preview: UIImageView!
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var name: UILabel!

    func populateCell(model: ProductListCellViewModel) {
        name.text = model.name
        if let url = URL(string: model.image) {
            preview.load(from: url)
        }
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

private extension ProductListCell {
    enum Constants {
        static let shadowRadius: CGFloat = 5
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowOpacity: Float = 0.12
    }

    func setupView() {
        preview.clipsToBounds = true
        preview.contentMode = .scaleAspectFill
        container.layer.shadowRadius = Constants.shadowRadius
        container.layer.shadowOffset = Constants.shadowOffset
        container.layer.shadowOpacity = Constants.shadowOpacity
    }
}
