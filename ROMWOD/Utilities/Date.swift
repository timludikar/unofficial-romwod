//
//  Date.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-02.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

extension Date {
    
    var simpleFormat: String? {
        let calendar = Calendar(identifier: .iso8601)
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)-\(month)-\(day)"
    }
    
    var startOfWeek: Date? {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar(identifier: .iso8601)
        guard let startOfWeek = startOfWeek else { return nil }
        return calendar.date(byAdding: .day, value: 7, to: startOfWeek)
    }
    
    static let timestamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    static let yyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
