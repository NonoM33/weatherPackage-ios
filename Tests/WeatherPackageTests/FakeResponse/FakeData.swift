//
//  File.swift
//  
//
//  Created by renaud on 23/11/2023.
//

import Foundation

enum TestError: Error {
    case testNetworkError
}

public class FakeData {

    static let fetchWeatherDetailDataSuccess = """
        {
            "lat": 33.44,
            "lon": -94.04,
            "timezone": "America/Chicago",
            "timezone_offset": -21600,
            "current": {
                "dt": 1700513892,
                "sunrise": 1700484732,
                "sunset": 1700521897,
                "temp": 291.45,
                "feels_like": 291.76,
                "pressure": 1005,
                "humidity": 93,
                "dew_point": 290.3,
                "uvi": 0.2,
                "clouds": 100,
                "visibility": 9656,
                "wind_speed": 0.89,
                "wind_deg": 118,
                "wind_gust": 1.79,
                "weather": [{"id": 701, "main": "Mist", "description": "brume", "icon": "50d"}]
            },
            "minutely": [{"dt": 1700513940, "precipitation": 0}],
            "hourly": [{"dt": 1700510400, "temp": 291.26, "feels_like": 290.0}],
            "daily": [{"dt": 1700503200, "temp": {"day": 291.14}}]
        }
""".data(using: .utf8)

    static let fetchWeatherDataSuccess = """
            {
            "coord": {
                "lon": 2.2945,
                "lat": 48.7523
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "nuageux",
                    "icon": "04n"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 282.81,
                "feels_like": 280.46,
                "temp_min": 281.86,
                "temp_max": 283.41,
                "pressure": 1012,
                "humidity": 93
            },
            "visibility": 10000,
            "wind": {
                "speed": 4.63,
                "deg": 280
            },
            "clouds": {
                "all": 75
            },
            "dt": 1700513996,
            "sys": {
                "type": 1,
                "id": 6548,
                "country": "FR",
                "sunrise": 1700463996,
                "sunset": 1700496385
            },
            "timezone": 3600,
            "id": 3037423,
            "name": "Antony",
            "cod": 200
        }
""".data(using: .utf8)

}
