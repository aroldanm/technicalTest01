//
//  SeriesList.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

struct SeriesList {
    private(set) var list = [Serie]()

    mutating func append(_ serie: Serie) {
        list.append(serie)
    }
}
