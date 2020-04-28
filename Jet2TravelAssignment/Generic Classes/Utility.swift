//
//  Utility.swift
//  Jet2TravelAssignment
//
//  Created by Chetan Girase on 29/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation

public func formatNumber(_ n: Int) -> String {
    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""
    
    switch num {
    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)B"
    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)M"
    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)K"
    case 0...:
        return "\(n)"
    default:
        return "\(sign)\(n)"
        
    }
}
