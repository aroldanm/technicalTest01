//
//  SeriesListResponse.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 28/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class SeriesListResponse {
    var list: [SeriesItem]?

    init(data: Data) throws {
        list = try JSONDecoder().decode(Array<SeriesItem>.self, from: data)
    }
}
