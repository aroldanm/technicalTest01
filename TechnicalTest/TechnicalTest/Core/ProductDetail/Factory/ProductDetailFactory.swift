//
//  ProductDetailFactory.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductDetailFactory {
    static func make(with product: Product) -> UIViewController {
        let viewController = ProductDetailViewController()
        let presenter = ProductDetailPresenterImpl(product: product,
                                                   delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
