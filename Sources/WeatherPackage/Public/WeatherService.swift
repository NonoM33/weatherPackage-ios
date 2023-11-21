//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation
import UIKit

public class WeatherService {

    public static let shared = WeatherService()

    private let apiClient = APIClient()

    private init() {}

  
    public func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<RESTWeatherGlobal, Error>) -> Void) {
        fetchWeatherCity(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let restWeatherCity):
                self?.fetchWeatherDetail(latitude: latitude, longitude: longitude, restWeatherCity: restWeatherCity, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

        // MARK: - Private

    private func fetchWeatherCity(latitude: Double, longitude: Double, completion: @escaping (Result<RESTWeatherCity, Error>) -> Void) {
        apiClient.fetchWeatherForCity(latitude: latitude, longitude: longitude, completion: completion)
    }

    private func fetchWeatherDetail(latitude: Double, longitude: Double, restWeatherCity: RESTWeatherCity, completion: @escaping (Result<RESTWeatherGlobal, Error>) -> Void) {
        apiClient.fetchWeatherDetail(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let restWeatherDetail):
                let restGlobal = RESTWeatherGlobal(RESTWeatherCity: restWeatherCity, RESTDetaillWeather: restWeatherDetail)
                completion(.success(restGlobal))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
