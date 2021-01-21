//
//  WeatherRequest.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation

struct WeatherRequest {
    
    let url: URL
    let location: String
    let date: String
    
    /**
     Initializes `WeatherRequest` with URL, and locationID
    
     - parameters:
        - url: Base URL
        - location: location Id
        - date: date for which weather needs to be fetched
     */
    init(url: URL, location: String, date: String) {
        self.url = url
        self.location = location
        self.date = date
    }
}

extension WeatherRequest: DataRequest, ParameteredRequest {
    typealias Response = Weather
    
    var endPoint: String {
        return "/api/location/\(self.location)/\(self.date)"
    }
    
    func expressAsURLRequest() throws -> URLRequest {
        try self.buildURL()
    }
    
    func buildURL() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.path = self.endPoint
        components.host = self.url.absoluteString
        guard
            components.host != nil,
            let localUrl = components.url else {
            let errorMessage = components.queryItems?.map { String(describing: $0) }.joined(separator: ", ") ?? ""
            throw BuilderError.unableBuildURL(message: "query item \(errorMessage)")
        }
        
        return URLRequest(url: localUrl,
                                    cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData,
                                    timeoutInterval: 30)
    }
}
