//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dhananjay Kumar DUbey on 19/1/21.
//


import Foundation

enum NetworkErrors {
    
    /**
     RequestError
     
        - invalidURL: Returned when API client fails to create a valid `URL`.
     */
    enum RequestError: Error {
        case invalidURL
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Something went wrong.\n Please try again later"
            }
        }
    }
    
    /**
     ResponseError
     
        - noDataAvailable: Returned when server response contains no data or empty data.
     */
    enum ResponseError: Error {
        case noDataAvailable
        
        var errorDescription: String? {
            switch self {
            case .noDataAvailable:
                return "Something went wrong.\n Please try again later"
            }
        }
    }
    
    /**
     ParsingError
     
        - unableToParse: Returned when received server response data could not be parsed.
     */
    enum ParsingError: Error {
        case unableToParse
        
        var errorDescription: String? {
            switch self {
            case .unableToParse:
                return "Something went wrong.\n Please try again later"
            }
        }
    }
}
