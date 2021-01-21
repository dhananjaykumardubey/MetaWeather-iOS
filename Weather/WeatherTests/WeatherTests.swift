//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Sushil Nagarale on 21/1/21.
//

import XCTest

@testable import Weather

class WeatherTests: XCTestCase {
    
    private var weatherLists: Weather?
    
    override func setUpWithError() throws {
        do {
            self.weatherLists = try JSONDecoder().decode(Weather.self, from: Stubbed.successStubbedData)
            XCTAssertEqual(self.weatherLists?.count, 1)
        } catch {
            XCTFail()
        }
    }
    
    override func tearDownWithError() throws {
        self.weatherLists = nil
    }
    
    func testWeatherModelSuccessfulParsing() {
        guard let weather = weatherLists?.first
        else {
            XCTFail("weather list not there")
            return
        }
        
        XCTAssertEqual(weather.state, .lightRain)
        XCTAssertEqual(weather.humidity, "94.00")
        XCTAssertEqual(weather.stateName, "Light Rain")
        XCTAssertEqual(weather.stateAbbreviation, "lr")
        XCTAssertEqual(weather.minTemp, "2.35")
        XCTAssertEqual(weather.maxTemp, "4.56")
        XCTAssertEqual(weather.theTemp, "3.69")
    }
    
    func testTempValueFailureForWrongDoubleValues() {
        guard let weather = weatherLists?.first
        else {
            XCTFail("weather list not there")
            return
        }
        XCTAssertNotEqual(weather.humidity, "94")
        XCTAssertNotEqual(weather.minTemp, "2.355")
        XCTAssertNotEqual(weather.maxTemp, "4.5649999999999995")
    }
}
