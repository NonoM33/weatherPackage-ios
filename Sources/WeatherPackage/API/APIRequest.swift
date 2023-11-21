//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

enum APIRequest {
    case weather(latitude: Double, longitude: Double)

    var url: URL? {
        guard let languageCode = Locale.current.languageCode else { return nil }
        switch self {
        case .weather(let latitude, let longitude):
            let apiKey = "0936af5f09c081d03f9836336c844af4"
            let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&lang=\(languageCode)"
            return URL(string: urlString)
        case .wikipediaImage(let cityName):
            let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            let urlString = "https://en.wikipedia.org/w/api.php?action=query&titles=\(encodedCityName)&prop=images&format=json"
            return URL(string: urlString)
        }
    }
}
