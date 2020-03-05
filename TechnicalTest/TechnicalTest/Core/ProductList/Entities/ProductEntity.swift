//
//  Product.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 29/02/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

struct ProductEntity: Codable {
    var id: Int?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var premiered: String?
    var officialSite: String?
    var schedule: Schedule?
    var rating: Rating?
    var weight: Int?
    var network: Network?
    var webChannel: WebChannel?
    var externals: Externals?
    var image: Image?
    var summary: String?
    var updated: Int?
}

extension ProductEntity {
    struct Rating: Codable {
        var average: Double?
    }

    struct Schedule: Codable {
        var time: String?
        var days: [String]?
    }

    struct Network: Codable {
        var id: Int?
        var name: String?
        var country: Country?
    }

    struct WebChannel: Codable {
        var id: Int?
        var name: String?
        var country: Country?
    }

    struct Country: Codable {
        var name: String?
        var code: String?
        var timezone: String?
    }

    struct Externals: Codable {
        var tvrage: Int?
        var thetvdb: Int?
        var imdb: String?
    }

    struct Image: Codable {
        var medium: String?
        var original: String?
    }
}
