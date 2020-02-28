//
//  SeriesListFactory.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class SeriesListFactory: Factory {
    private static var viewController: UIViewController {
        let viewController = SeriesListViewController()
        let dataProvider = SeriesListDataProviderImpl()
        let interactor = SeriesListInteractorImpl(dataProvider: dataProvider)
        let router = SeriesListRouterImpl()
        let presenter = SeriesListPresenterImpl(interactor: interactor,
                                                router: router,
                                                delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }

    static func make() -> UIViewController {
        return viewController
    }
}
