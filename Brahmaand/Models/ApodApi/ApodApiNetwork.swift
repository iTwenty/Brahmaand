//
//  APODAPINetwork.swift
//  Brahmaand
//
//  Created by jaydeep on 23/03/21.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case apiError
    case jsonError
}

let apiKey = "4UaeSwbkBvlM4x9Bxuu02HefDlpyPgHbP1NbA9F4"
let baseUrl = "https://api.nasa.gov/planetary/apod"

final class ApodApiNetwork: ApodNetwork {

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Constants.DateFormatters.apodApiFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetchApod(forDate date: Date, completion: @escaping (Result<Apod, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }

        let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "date", value: date.apodApiFormatted())]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(ApiError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        fetch(request: request, completion: completion)
    }

    func fetchApods(startDate: Date, endDate: Date, completion: @escaping (Result<[Apod], Error>) -> ()) {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }

        let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "start_date", value: startDate.apodApiFormatted()),
                          URLQueryItem(name: "end_date", value: endDate.apodApiFormatted())]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(ApiError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        fetch(request: request, completion: completion)
    }

    private func fetch<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { [weak self] (dataOpt, responseOpt, errorOpt) in
            guard let self = self else { return }
            if let error = errorOpt {
                print("API Error : \(error.localizedDescription)")
                completion(.failure(ApiError.apiError))
                return
            }
            guard let response = responseOpt as? HTTPURLResponse else {
                print("API Error: No response")
                completion(.failure(ApiError.apiError))
                return
            }
            guard response.statusCode == 200 else {
                if let data = dataOpt {
                    print("API Error : \(response.statusCode) - \(String(data: data, encoding: .utf8) ?? "whoops")")
                } else {
                    print("API Error: \(response.statusCode)")
                }
                completion(.failure(ApiError.apiError))
                return
            }
            guard let data = dataOpt else {
                print("API Error : 200 from server, but no data")
                completion(.failure(ApiError.apiError))
                return
            }
            do {
                let successResult = try self.decoder.decode(T.self, from: data)
                completion(.success(successResult))
            } catch {
                print("JSON Error : \(error.localizedDescription)")
                completion(.failure(ApiError.jsonError))
            }
        }
        task.resume()
    }
}
