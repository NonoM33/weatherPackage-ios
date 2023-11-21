//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

public struct RESTDetaillWeather: Codable {
    public let current: CurrentWeather
    public let minutely: [MinutelyWeather]

    public enum CodingKeys: String, CodingKey {
        case current, minutely
    }
}

public struct CurrentWeather: Codable {
    public let dt: Int
    public let sunrise: Int
    public let sunset: Int
    public let temp: Double
    public let feelsLike: Double
    public let pressure: Int
    public let humidity: Int
    public let dewPoint: Double
    public let uvi: Double
    public let clouds: Int
    public let visibility: Int
    public let windSpeed: Double
    public let windDeg: Int
    public let weather: [WeatherDetail]
    public let rain: Rain?

    public enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, clouds, visibility, weather, rain
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case uvi
    }
}

public struct WeatherDetail: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct Rain: Codable {
    public let oneHour: Double

    public enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

public struct MinutelyWeather: Codable {
    public let dt: Int
    public let precipitation: Double
}