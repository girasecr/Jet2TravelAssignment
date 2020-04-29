//
//  APIConfiguration.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

struct Basic {
    static let url = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=50"
    static var timeout = 60.0
}

public struct HEADERS {
    static let appJson: [String: String] = ["Content-Type": "application/json; charset=UTF-8"]
}

class APIConfiguration {
    var extraParameters: String
    var httpMethod: HTTPMethod
    var requestObject: Encodable?

    init(extraParameters: String = "", httpMethod: HTTPMethod = .get, requestObject: Encodable? = nil) {
        self.extraParameters = extraParameters
        self.httpMethod = httpMethod
        self.requestObject = requestObject
    }

    fileprivate func getUrl() -> URL? {
        let urlString = String(format: "%@%@", Basic.url, self.extraParameters)
        return URL.init(string: urlString)
    }

    fileprivate func httpBody() -> Data? {
        var data: Data?
        if let jsonData = self.requestObject?.toJSONData() {
            var jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            jsonString = jsonString.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
            data = jsonString.data(using: .utf8, allowLossyConversion: false)
        }
        return data
    }

    func configuration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Basic.timeout
        return configuration
    }

    func getURLRequest() -> URLRequest? {
        guard let url = getUrl() else { return nil }
        return URLRequest.init(url: url)
    }

    func postURLRequest() -> URLRequest? {
        guard let url = getUrl() else { return nil }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = HEADERS.appJson
        urlRequest.httpBody = self.httpBody()
        return urlRequest
    }
}
