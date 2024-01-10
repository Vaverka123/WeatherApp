////
////  API.swift
////  WeatherApp
////
////  Created by Vera Maslava on 8.01.24.
////

import Foundation

final class APIManager {
// private let apiKey = "aadf014bb0e02cab417fb007f23b93d4"
// let currentWeather = "weather"
// let forecast = "forecast"

    func loadWeather(completion: @escaping (Result <WeatherStructure, Error>) -> Void) {
        guard let urlWeather = URL(string:  "https://api.openweathermap.org/data/2.5/weather?q=London&units=metric&appid=aadf014bb0e02cab417fb007f23b93d4") else { return }
              
                
        let sessionWeather = URLSession.shared.dataTask(with: URLRequest(url: urlWeather)) { data, response, error in
            if let error {
                completion(.failure(error))
          } else if let data = data {
              do {
                  let weatherStructure = try JSONDecoder().decode(WeatherStructure.self, from: data)
                  completion(.success(weatherStructure))
              } catch {
                  completion(.failure(error))
              }
          }
      }
      
      sessionWeather.resume()
  }
}
