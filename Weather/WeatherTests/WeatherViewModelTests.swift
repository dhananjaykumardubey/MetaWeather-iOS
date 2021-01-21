//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Sushil Nagarale on 21/1/21.
//

import XCTest

@testable import Weather

class WeatherViewModelTests: XCTestCase {

    private var viewModel: WeatherViewModel?
    private var mock: NetworkSessionMock!
    
    override func setUp() {
        self.mock = NetworkSessionMock()
        self.viewModel = WeatherViewModel(with: WeatherAPIClient(baseURL: URL(string: "www.abc.com")!,
                                                                 networkSession: self.mock))
    }

    override func tearDown() {
        self.viewModel = nil
        self.mock = nil
    }

    func testSourceLocations() {
        XCTAssertNotNil(self.viewModel?.sourceLocations)
        XCTAssertEqual(self.viewModel?.sourceLocations.count, 6)
        XCTAssertEqual(self.viewModel?.sourceLocations.first?.title, "Stockholm")
        XCTAssertEqual(self.viewModel?.sourceLocations.last?.title, "Berlin")
    }
    
    func testFetchinWeatherReportSuccessfully() {
        self.mock.response = .success(Stubbed.successStubbedData)
        let expectation = self.expectation(description: "Expect success")
        
        self.viewModel?.getWeatherReport(for: "906057", for: "2021/1/22")
        self.viewModel?.weatherReport = { data in
            expectation.fulfill()
            XCTAssertNotNil(data)
            XCTAssertEqual(data?.humidity, "94.00")
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
}
