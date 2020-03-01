//
//  ActivityIndicatorCell.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ActivityIndicatorCell: UITableViewCell, CustomCell {
    static var identifier = "ActivityIndicatorCell"

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
