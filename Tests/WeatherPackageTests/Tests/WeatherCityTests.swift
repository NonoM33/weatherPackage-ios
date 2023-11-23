//
//  File.swift
//
//
//  Created by renaud on 23/11/2023.
//

import XCTest
@testable import WeatherPackage

class WeatherCityTests: XCTestCase {

    var apiclient: APIClient!
    var fakeSession: FakeURLSession!

    override func setUp() {
        super.setUp()
        fakeSession = FakeURLSession()
        apiclient = APIClient(session: fakeSession)
    }

    override func tearDown() {
        apiclient = nil
        fakeSession = nil
        super.tearDown()
    }

    func testFetchWeatherDetailDataSuccess() {
        fakeSession.data = FakeData.fetchWeatherDataSuccess
        let urlResponse = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org")!,
                                          statusCode: 200, httpVersion: nil, headerFields: nil)
        fakeSession.response = urlResponse

        let expectation = XCTestExpectation(description: "Fetch weather data successfully")

        apiclient.fetchWeatherForCity(latitude: 33.4, longitude: -94.04) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let failure):
                XCTFail("Test failed with error: \(failure)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }


    func testFetchWeatherDetailDataFailure() {
        fakeSession.error = TestError.testNetworkError

        let expectation = XCTestExpectation(description: "Fetch weather data fails with network error")

        apiclient.fetchWeatherForCity(latitude: 33.4, longitude: -94.04) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure:
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}


