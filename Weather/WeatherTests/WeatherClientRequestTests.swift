//
//  WeatherClientRequestTests.swift
//  WeatherTests
//
//  Created by Dhananjay Kumar Dubey on 21/1/21.
//

import XCTest

@testable import Weather


class WeatherClientRequestTests: XCTestCase {

    var mock: NetworkSessionMock!
    
    override func setUpWithError() throws {
        self.mock = NetworkSessionMock()
    }

    override func tearDownWithError() throws {
        self.mock = nil
    }
    
    func testExpectSuccessFullResponseWhenValidJSONIsAvailable() {

        self.mock.response = .success(Stubbed.successStubbedData)
        
        let client = WeatherAPIClient.init(baseURL: URL(string: "https://abc.com")!, networkSession: self.mock)
        
        let expectation = self.expectation(description: "Expect success")
                
        client.fetchWeatherReport(for: "dummyLocation", and: "dummyDate") { response in
            expectation.fulfill()
            XCTAssertNotNil(response.value)
            XCTAssertEqual(response.value?.count, 1)
            XCTAssertEqual(response.value?.first?.stateName, "Light Rain")
        }
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testRequest() {
        let client = WeatherAPIClient.init(baseURL: URL(string: "www.abc.com")!, networkSession: self.mock)
        
        let expectation = self.expectation(description: "Expect success")
        
        client.fetchWeatherReport(for: "123456", and: "date") { _ in
            expectation.fulfill()
        }
        
        guard let receivedRequest = self.mock.request as? WeatherRequest else {
            XCTFail("Invalid request received expected was WeatherRequest")
            return
        }
        
        XCTAssertEqual(receivedRequest.url.absoluteString, "www.abc.com")
        XCTAssertEqual(receivedRequest.location, "123456")
        XCTAssertEqual(receivedRequest.date, "date")
        XCTAssertEqual(try receivedRequest.expressAsURLRequest().url?.absoluteString,
                       URLRequest(url: URL(string: "https://www.abc.com/api/location/123456/date")!).url?.absoluteString)
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testExpectErrorsWhenInValidJSONSet() {
        
        self.mock.response = .success(Data())
        
        let client = WeatherAPIClient.init(baseURL: URL(string: "https://www.abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect failure")
                
        client.fetchWeatherReport(for: "location", and: "date") { response in
            expectation.fulfill()
            XCTAssertNil(response.value)
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.error is DecodingError)
        }
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testResponseForInvalidLocationId() {
        self.mock.response = .failed(NetworkErrors.ResponseError.noDataAvailable)
        
        let client = WeatherAPIClient.init(baseURL: URL(string: "https://www.abc.com")!, networkSession: self.mock)
        let expectation = self.expectation(description: "Expect failure")
        
        client.fetchWeatherReport(for: "InvalidLocationId", and: "dummyDate") { response in
            expectation.fulfill()
            XCTAssertNil(response.value)
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.error is NetworkErrors.ResponseError)
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
}
