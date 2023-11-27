//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

public struct RESTDetaillWeather: Codable {
    public let current: CurrentWeather
    public let hourly: [HourlyWeather]
    public let daily: [DailyWeather]
    public let lat: Double?
    public let lon: Double?

    public enum CodingKeys: String, CodingKey {
        case current, hourly, daily, lat, lon
    }
}

public struct CurrentWeather: Codable {
    public let dt: Int?
    public let sunrise: Int?
    public let sunset: Int?
    public let temp: Double?
    public let feelsLike: Double?
    public let pressure: Int?
    public let humidity: Int?
    public let dewPoint: Double?
    public let uvi: Double?
    public let clouds: Int?
    public let visibility: Int?
    public let windSpeed: Double?
    public let windDeg: Int?
    public let weather: [WeatherDetail]?
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
    public let id: Int?
    public let main: String?
    public let description: String?
    public let icon: String?
}

public struct Rain: Codable {
    public let oneHour: Double?

    public enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

public struct HourlyWeather: Codable {
    public let dt: Int?
    public let temp: Double?
    public let feelsLike: Double?
    public let pressure: Int?
    public let humidity: Int?
    public let dewPoint: Double?
    public let uvi: Double?
    public let clouds: Int?
    public let visibility: Int?
    public let windSpeed: Double?
    public let windDeg: Int?
    public let windGust: Double?
    public let weather: [WeatherDetail]?
    public let pop: Double?
    public let rain: Rain??

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case pop
        case rain
    }
}

public struct DailyWeather: Codable {
    public let dt: Int?
    public let sunrise: Int?
    public let sunset: Int?
    public let moonrise: Int?
    public let moonset: Int?
    public let moonPhase: Double?
    public let temp: Temperature?
    public let feelsLike: FeelsLike?
    public let pressure: Int?
    public let humidity: Int?
    public let dewPoint: Double?
    public let windSpeed: Double?
    public let windDeg: Int?
    public let windGust: Double?
    public let weather: [WeatherDetail]?
    public let clouds: Int?
    public let pop: Double?
    public let uvi: Double?

    public enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case clouds
        case pop
        case uvi
    }
}

public struct Temperature: Codable {
    public let day: Double?
    public let min: Double?
    public let max: Double?
    public let night: Double?
    public let eve: Double?
    public let morn: Double?
}

public struct FeelsLike: Codable {
    public let day: Double?
    public let night: Double?
    public let eve: Double?
    public let morn: Double?
}
