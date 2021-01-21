//
//  NetworkSessionMock.swift
//  WeatherTests
//
//  Created by Dhananjay Kumar Dubey on 21/1/21.
//

import Foundation

@testable import Weather

class NetworkSessionMock: NetworkSession {
    enum  NetworkSessionMockError: Error {
        case responseIsNotSet
    }
    var request: URLRequestConvertible?
    var url: URL?
    var response: Result<Data>?
    
    func call(_ request: URLRequestConvertible, then completionHandler: @escaping ((Result<Data>) -> Void)) {
        
        do {
            self.request = request
            self.url = try request.expressAsURLRequest().url
            guard let response = self.response else {
                completionHandler(.failed(NetworkSessionMockError.responseIsNotSet))
                return
            }
            completionHandler(response)
        } catch {
            completionHandler(.failed(error))
        }
        
    }
}
