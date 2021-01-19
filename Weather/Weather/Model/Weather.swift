//
//  Weather.swift
//  Weather
//
//  Created by Sushil Nagarale on 19/1/21.
//

import Foundation

struct Weather: Codable {
    let data: [ConsolidatedWeather]
}

struct ConsolidatedWeather {
    let stateName: String?
    let stateAbbreviation: String?
    let minTemp: Double?
    let maxTemp: Double?
    let humidity: Double?
}

extension ConsolidatedWeather: Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        case stateName = "weather_state_name", stateAbbreviation = "weather_state_abbr",
             minTemp = "min_temp", maxTemp = "max_temp", humidity = "humidity"
    }

    public init() {
        self.stateName = ""
        self.stateAbbreviation = ""
        self.minTemp = 0.0
        self.maxTemp = 0.0
        self.humidity = 0.0
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        self.stateAbbreviation = try values.decodeIfPresent(String.self, forKey: .stateAbbreviation)
        self.minTemp = try values.decodeIfPresent(Double.self, forKey: .minTemp)
        self.maxTemp = try values.decodeIfPresent(Double.self, forKey: .maxTemp)
        self.humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
    }
    
    public func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(stateName, forKey: .stateName)
        try container.encodeIfPresent(stateAbbreviation, forKey: .stateAbbreviation)
        try container.encodeIfPresent(minTemp, forKey: .minTemp)
        try container.encodeIfPresent(maxTemp, forKey: .maxTemp)
        try container.encodeIfPresent(humidity, forKey: .humidity)
     }
}

/// DUMMY RESPONSE
//"id": 6225261444988928,
//     "weather_state_name": "Heavy Rain",
//     "weather_state_abbr": "hr",
//     "wind_direction_compass": "SSW",
//     "created": "2021-01-19T15:20:02.754425Z",
//     "applicable_date": "2021-01-20",
//     "min_temp": 9.165,
//     "max_temp": 11.54,
//     "the_temp": 10.09,
//     "wind_speed": 13.889736745812456,
//     "wind_direction": 204.1659632905465,
//     "air_pressure": 989.0,
//     "humidity": 84,
//     "visibility": 7.71898363556828,
//     "predictability": 77
