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

public func getDateFrom(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = formatter.date(from: dateString) {
        return date
    }
    
    return nil
}

public func getTimeBetween(_ startDate: Date?, end endDate: Date?) -> String? {
    var components: DateComponents?
    var days: Int
    var hour: Int
    var minutes: Int
    var durationString: String?
    
    if let startDate = startDate, let endDate = endDate {
        let units = Set<Calendar.Component>([.day, .hour, .minute])
        components = Calendar.current.dateComponents(units, from: startDate, to: endDate)
    }
    days = components?.day ?? 0
    hour = components?.hour ?? 0
    minutes = components?.minute ?? 0
    
    if days > 0 {
        if days > 1 {
            durationString = "\(days) days"
        } else {
            durationString = "\(days) day"
        }
        return durationString
    }
    
    if hour > 0 {
        if hour > 1 {
            durationString = "\(hour) hours"
        } else {
            durationString = "\(hour) hour"
        }
        return durationString
    }
    
    if minutes > 0 {
        if minutes > 1 {
            durationString = "\(minutes) minutes"
        } else {
            durationString = "\(minutes) minute"
        }
        return durationString
    }
    return ""
}
