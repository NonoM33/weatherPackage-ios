//
//  File.swift
//  
//
//  Created by renaud on 20/11/2023.
//

import Foundation

public struct RESTWeatherCity: Codable {

   public var weather: [WeatherCondition]
   public var base: String
   public var main: Main
   public var visibility: Int
   public var wind: Wind
   public var clouds: Clouds
   public var dt: Int
   public var sys: Sys
   public var timezone: Int
   public var id: Int
   public var name: String
   public var cod: Int
}

public struct WeatherCondition: Codable {
    public var id: Int
    public var main: String
    public var description: String
    public var icon: String
}

public struct Main: Codable {
    public var temp: Double
    public var feels_like: Double
    public var temp_min: Double
    public var temp_max: Double
    public var pressure: Int
    public var humidity: Int
}

public struct Wind: Codable {
    public var speed: Double
    public var deg: Int
}

public struct Clouds: Codable {
    public var all: Int
}

public struct Sys: Codable {
    public var type: Int
    public var id: Int
    public var country: String
    public var sunrise: Int
    public var sunset: Int
}
