//
//  Request.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 14/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

struct Request {
    let url: String
    let method: Method
    let params: [String: Any]
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum RequestError: Error {
    case invalidUrl
    case httpError(Int, URLResponse?)
    case invalidResponse(Error?)
    case unknown(Error?)
}
