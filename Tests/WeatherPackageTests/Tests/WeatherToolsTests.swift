//
//  File.swift
//  
//
//  Created by renaud on 23/11/2023.
//

import XCTest
@testable import WeatherPackage

class WeatherToolsTests: XCTestCase {

    func testConvertKelvinToCelsius() {
        let kelvin = 273.15
        let celsius = 23.0
        let kelvinTest = kelvin + celsius
        let celsiusExpect = WeatherTools.convertKelvinToCelsius(kelvin: kelvinTest)
        XCTAssertEqual(celsius, celsiusExpect)
    }

    func testColorForTemperature() {
        let kelvin = 273.15
        let celsius = 23.0 + kelvin
        let colorExpect = UIColor(red: max(0.5 - 0.2, 0), green: max(1 - 0.2, 0), blue: max(0.5 - 0.2, 0), alpha: 1)
        let color = WeatherTools.colorForTemperature(kelvin: celsius)
        XCTAssertEqual(color, colorExpect)
    }

    func testConvertUnixTimeToDate() {
        let unixTimeTest = 1700513996
        let dateExpect = "20/11/23"
        let date = WeatherTools.convertUnixTimeToDate(unixTime: unixTimeTest, dateFormat: "dd/MM/YY")
        XCTAssertEqual(date, dateExpect)
    }
}
