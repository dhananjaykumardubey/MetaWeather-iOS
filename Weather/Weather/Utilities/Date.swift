//
//  Date.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation

extension Date {
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
