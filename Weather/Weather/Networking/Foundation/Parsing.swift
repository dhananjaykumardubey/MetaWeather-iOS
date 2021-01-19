//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dhananjay Kumar DUbey on 19/1/21.
//

import Foundation

func parse<T: Decodable>(toType: T.Type, data: Data) throws -> T {
    return try JSONDecoder().decode(T.self, from: data)
}
