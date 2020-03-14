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

    @IBOutlet private weak var preview: UIImageView! {
        didSet {
            preview.clipsToBounds = true
            preview.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var container: UIView! {
        didSet {
            container.layer.shadowRadius = Constants.shadowRadius
            container.layer.shadowOffset = Constants.shadowOffset
            container.layer.shadowOpacity = Constants.shadowOpacity
        }
    }
    @IBOutlet private weak var name: UILabel! {
        didSet {
            name.adjustsFontSizeToFitWidth = true
            name.minimumScaleFactor = 0.9
        }
    }
    @IBOutlet private weak var sublabel: UILabel!

    private var sessionTask: URLSessionTask?

    func populateCell(model: ProductListCellViewModel) {
        name.text = model.name
        sublabel.text = model.genres

        sessionTask?.cancel()
        sessionTask = preview.load(from: model.image)
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
        static let shadowRadius: CGFloat = 4
        static let shadowOffset = CGSize(width: 1, height: 0)
        static let shadowOpacity: Float = 0.14
    }
}
