//
//  ProductListRouterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductListRouterImpl: ProductListRouter {
    func navigateToDetail(with product: Product, from viewController: UIViewController) {
        let destination = ProductDetailFactory.make(with: product)
        viewController.present(destination, animated: true, completion: nil)
    }
}
