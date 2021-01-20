//
//  WeatherState.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation

enum WeatherState {
    case snow
    case sleet
    case hail
    case thunderstorm
    case heavyRain
    case lightRain
    case showers
    case heavyCloud
    case lightCloud
    case clear
    case none
    
    var stateImageName: String {
        switch self {
        case .snow:
            return "snow"
        case .sleet:
            return "sleet"
        case .hail:
            return "hail"
        case .thunderstorm:
            return "thunderstorm"
        case .heavyRain:
            return "heavy_rain"
        case .lightRain:
            return "light_rain"
        case .showers:
            return "showers"
        case .heavyCloud:
            return "heavy_cloud"
        case .lightCloud:
            return "light_cloud"
        case .clear:
            return "clear"
        case .none:
            return ""
        }
    }
    
    static func state(from abbrevaiation: String) -> WeatherState {
        
        switch abbrevaiation.lowercased() {
        case "sn":
            return .snow
        case "sl":
            return .sleet
        case "h":
            return .hail
        case "t":
            return .thunderstorm
        case "hr":
            return .heavyRain
        case "lr":
            return .lightRain
        case "s":
            return .showers
        case "hc":
            return .heavyCloud
        case "lc":
            return .lightCloud
        case "c":
            return .clear
        default:
            return .none
        }
    }
}
