//
//  SeriesListViewController.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class SeriesListViewController: UIViewController {
    var presenter: SeriesListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SeriesListViewController: SeriesListViewDelegate {
}
