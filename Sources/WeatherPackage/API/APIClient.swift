//
//  File.swift
//  
//
//  Created by renaud on 15/11/2023.
//

import Foundation

class APIClient {

    static let shared = APIClient()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWeatherForCity(latitude: Double, longitude: Double, completion: @escaping (Result<RESTWeatherCity, Error>) -> Void) {
        performRequest(for: .weather(latitude: latitude, longitude: longitude)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let weatherCity = try decoder.decode(RESTWeatherCity.self, from: data)
                        completion(.success(weatherCity))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchWeatherDetail(latitude: Double, longitude: Double, completion: @escaping (Result<RESTDetaillWeather, Error>) -> Void) {
        performRequest(for: .weatherDetail(latitude: latitude, longitude: longitude)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let weatherCity = try decoder.decode(RESTDetaillWeather.self, from: data)
                        completion(.success(weatherCity))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - Private

    private func performRequest(for apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = apiRequest.url else {
            completion(.failure(APIError.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}

// APIError.swift

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case customError(Error)
}
