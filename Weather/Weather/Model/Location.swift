//
//  Location.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation

typealias Locations = [Location]

struct Location: Codable {
    let title: String
    let woeid: Int
    let timeZone: String
}
