//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dhananjay Kumar DUbey on 19/1/21.
//


import Foundation

protocol APIClient {
    
    init(baseURL: URL, networkSession: NetworkSession)

    func fetchWeatherReport(for location: String, and date: String, then completion: @escaping ((Result<Weather>) -> Void))
}

/// Responsible for providing required content fetched from server.
struct WeatherAPIClient: APIClient {
    
    private let baseURL: URL
    private let networkSession: NetworkSession
    /**
     Initializes `WeatherAPIClient` with provided URL, api_key and session
     
     - parameters:
        - baseURL: Base URL
     */
    init(baseURL: URL, networkSession: NetworkSession = URLSession(configuration: .ephemeral)) {
        self.baseURL = baseURL
        self.networkSession = networkSession
    }
    /**
      Weather for location request call, returns the details of weather parsed into `Weather`
     - parameters:
         - location: location for which details needs to be fetched
         - completion: completion handler which returns service response, either failed with error, or successfull album details.
     
     */
    func fetchWeatherReport(for location: String, and date: String, then completion: @escaping ((Result<Weather>) -> Void)) {
        let request = WeatherRequest(url: self.baseURL, location: location, date: date)
        request.execute(onNetwork: self.networkSession, then: completion)
    }
}
