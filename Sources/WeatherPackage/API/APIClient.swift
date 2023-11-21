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

    func fetchWikipediaImageForCity(cityName: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        performRequest(for: .wikipediaImage(cityName: cityName)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.parseWikipediaImageListData(from: data, cityName: cityName) { imageResult in
                        switch imageResult {
                        case .success(let imageUrl):
                            self.downloadImage(from: imageUrl, completion: completion)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - Private

    private func parseWikipediaImageListData(from data: Data, cityName: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let jsonResult = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let query = jsonResult["query"] as? [String: Any],
              let pages = query["pages"] as? [String: Any],
              let page = pages.values.first as? [String: Any],
              let images = page["images"] as? [[String: Any]] else {
            completion(.failure(APIError.invalidResponse))
            return
        }

        // Trouver le nom de fichier d'image qui correspond le mieux à la ville
        for imageInfo in images {
            if let title = imageInfo["title"] as? String, title.contains(cityName) {
                // Convertir le nom de l'image en URL
                let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
                let imageUrlString = "https://en.wikipedia.org/wiki/Special:FilePath/\(encodedTitle)"
                if let imageUrl = URL(string: imageUrlString) {
                    completion(.success(imageUrl))
                    return
                } else {
                    completion(.failure(APIError.invalidURL))
                    return
                }
            }
        }

        completion(.failure(APIError.noData))
    }
    private func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(APIError.noData))
                    return
                }

                completion(.success(image))
            }
        }.resume()
    }

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
