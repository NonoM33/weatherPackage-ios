//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

public class WeatherService {

    public static let shared = WeatherService()

    private let apiClient = APIClient()

    private init() {}

    public func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<RESTWeatherGlobal, Error>) -> Void) {
        var restGlobal = RESTWeatherGlobal(RESTWeatherCity: nil, RESTDetaillWeather: nil)
        apiClient.fetchWeatherForCity(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let restWeatherCity):
                restGlobal.RESTWeatherCity = restWeatherCity
                self?.apiClient.fetchWeatherDetail(latitude: latitude, longitude: longitude) { result in
                    switch result {
                    case .success(let restWeatherDetail):
                        restGlobal.RESTDetaillWeather = restWeatherDetail
                        completion(.success(restGlobal))
                    case .failure(let failure):
                        print(failure)
                        completion(.failure(failure))
                    }
                }
            case .failure(let failure):
                print(failure)
                completion(.failure(failure))
            }
        }
    }
}
