//
//  ProductListFactory.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class ProductListFactory: Factory {
    private static var viewController: UIViewController {
        let viewController = ProductListViewController()
        let dataProvider = ProductListDataProviderImpl()
        let interactor = ProductListInteractorImpl(dataProvider: dataProvider)
        let router = ProductListRouterImpl()
        let presenter = ProductListPresenterImpl(interactor: interactor,
                                                 router: router,
                                                 view: viewController)
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }

    static func make() -> UIViewController {
        return viewController
    }
}
