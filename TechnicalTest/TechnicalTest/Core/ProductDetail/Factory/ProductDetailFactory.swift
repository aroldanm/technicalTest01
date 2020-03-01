//
//  ProductDetailFactory.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 01/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductDetailFactory {
    private static var viewController:  UIViewController {
        return UIViewController()
    }

    static func make(with product: Product) -> UIViewController {
        return viewController
    }
}
