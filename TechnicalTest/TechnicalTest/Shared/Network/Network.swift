//
//  Network.swift
//  TechnicalTest
//
//  Created by Alan Roldán Maillo on 14/03/2020.
//  Copyright © 2020 Alan Roldán Maillo. All rights reserved.
//

import Foundation

class Network {
    typealias Success = (Data) -> Void
    typealias Failure = (RequestError) -> Void
    
    static func request(_ request: Request, success: @escaping Success, failure: @escaping Failure) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfig.urlCache = nil
        let session = URLSession(configuration: sessionConfig)

        let params = (request.params.compactMap({ (key, value) -> String in
            return key + Symbol.equal + String(describing: value)
        }) as Array).joined(separator: Symbol.separator)
        
        var stringUrl = request.url
        if request.method == .get {
            stringUrl += Symbol.params + params
        }

        guard let url = URL(string: stringUrl) else {
            failure(.invalidUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = url
        urlRequest.httpMethod = request.method.rawValue

        if request.method == .post {
            urlRequest.httpBody = params.data(using: .utf8)
        }

        session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                failure(.unknown(error))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse,
                httpStatus.statusCode != 200 {
                failure(.httpError(httpStatus.statusCode, response))
            }
            
            success(data)
        }.resume()
    }
}

private extension Network {
    enum Symbol {
        static let equal = "="
        static let separator = "&"
        static let params = "?"
    }
}
