//
//  SeriesListPresenterImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class SeriesListPresenterImpl: SeriesListPresenter {
    private weak var delegate: SeriesListViewDelegate?
    private let interactor: SeriesListInteractor
    private let router: SeriesListRouter

    init(interactor: SeriesListInteractor, router: SeriesListRouter, delegate: SeriesListViewDelegate) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}
