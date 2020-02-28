//
//  SeriesListInteractorImpl.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

class SeriesListInteractorImpl: SeriesListInteractor {
    private let dataProvider: SeriesListDataProvider

    init(dataProvider: SeriesListDataProvider) {
        self.dataProvider = dataProvider
    }
}
