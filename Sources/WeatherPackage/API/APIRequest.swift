//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

enum APIRequest {
    case weather(latitude: Double, longitude: Double, apiKey: String)
    case weatherDetail(latitude: Double, longitude: Double, apiKey: String)

    var url: URL? {
        switch self {
        case .weather(let latitude, let longitude,let apiKey):
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&lang=fr"
            return URL(string: urlString)
        case .weatherDetail(let latitude, let longitude, let apiKey):
            let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&lang=fr"
            return URL(string: urlString)
        }
    }
}

