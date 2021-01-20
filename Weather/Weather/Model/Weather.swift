//
//  Weather.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
//

import Foundation

typealias Weather  = [ConsolidatedWeather]

struct ConsolidatedWeather {
    let stateName: String?
    let stateAbbreviation: String?
    let minTemp: String
    let maxTemp: String
    let theTemp: String
    let humidity: String
    let state: WeatherState
}

extension ConsolidatedWeather: Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        case stateName = "weather_state_name", stateAbbreviation = "weather_state_abbr",
             minTemp = "min_temp", maxTemp = "max_temp", humidity = "humidity", theTemp = "the_temp"
    }
    
    public init() {
        self.stateName = ""
        self.stateAbbreviation = ""
        self.minTemp = ""
        self.maxTemp = ""
        self.humidity = ""
        self.theTemp = ""
        self.state = .none
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        self.stateAbbreviation = try values.decodeIfPresent(String.self, forKey: .stateAbbreviation)
        
        let minTemp = try values.decodeIfPresent(Double.self, forKey: .minTemp)
        self.minTemp = String(format: "%.2f", minTemp ?? 0.0)
        
        let maxTemp = try values.decodeIfPresent(Double.self, forKey: .maxTemp)
        self.maxTemp = String(format: "%.2f", maxTemp ?? 0.0)
        
        let theTemp = try values.decodeIfPresent(Double.self, forKey: .theTemp)
        self.theTemp = String(format: "%.2f", theTemp ?? 0.0)
        
        let humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        self.humidity = String(format: "%.2f", humidity ?? 0.0)
        
        self.state = WeatherState.state(from: self.stateAbbreviation ?? "")
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(stateName, forKey: .stateName)
        try container.encodeIfPresent(stateAbbreviation, forKey: .stateAbbreviation)
        try container.encodeIfPresent(minTemp, forKey: .minTemp)
        try container.encodeIfPresent(maxTemp, forKey: .maxTemp)
        try container.encodeIfPresent(theTemp, forKey: .theTemp)
        try container.encodeIfPresent(humidity, forKey: .humidity)
    }
}
