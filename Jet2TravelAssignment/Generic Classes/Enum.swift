//
//  Enum.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 28/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct GLOBAL_CONSTANTS {
    static let articleCornerRadius = 5.0
    static let deafultImageViewHeight = 200
    static let loadMorePageSize = 10
    static let alertTitle = "Jet2 Travel App"
    static let alertMsg = "No Internet Connection"
    static let alertButtonName = "Ok"
}

