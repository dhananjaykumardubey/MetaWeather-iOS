//
//  WeatherRequest.swift
//  Weather
//
//  Created by Sushil Nagarale on 20/1/21.
//

import Foundation

struct WeatherRequest {
    
    let url: URL
    let locationId: String
    
    /**
     Initializes `WeatherRequest` with URL, and locationID
    
     - parameters:
        - url: Base URL
        - locationId: location Id for which weather is to be fetched
     */
    init(url: URL, locationId: String) {
        self.url = url
        self.locationId = locationId
    }
}

extension WeatherRequest: DataRequest, ParameteredRequest {    
    typealias Response = Weather
    
    /**
     Provides request parameter which needs to be paased as query parameter in URL component, and used by request builder to create a complete url request
     - returns: A dictionary of request parameters
     */
    func parameter() -> [String : String] {
        return [:]
    }
}
