////
////  API.swift
////  WeatherApp
////
////  Created by Vera Maslava on 8.01.24.
////

import Foundation


final class APIManager {
    
    var apiKey: String?
    
    init() {
        loadConfiguration()
    }
   
    func loadConfiguration() {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
           let configDict = NSDictionary(contentsOfFile: path) as? [String: Any],
           let apiKey = configDict["apiKey"] as? String {
            self.apiKey = apiKey
        } else {
            print("Error: Unable to read API Key from configuration file")
        }
    }
    
    func loadWeather(city: String, completion: @escaping (Result <WeatherAPI.WeatherStructure, Error>) -> Void) {

        guard let apiKey = apiKey else {
            completion(.failure(APIError.apiKeyNotLoaded))
            return
        }
                
        guard let urlWeather = URL(string:  "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)") else { return }
        
        let sessionWeather = URLSession.shared.dataTask(with: URLRequest(url: urlWeather)) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let weatherStructure = try JSONDecoder().decode(WeatherAPI.WeatherStructure.self, from: data)
                    completion(.success(weatherStructure))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        sessionWeather.resume()
    }
    
    func loadHourlyForecast(city: String, completion: @escaping (Result<DailyForecastAPI.DailyForecastStructure, Error>) -> Void) {
        
        guard let apiKey = apiKey else {
            completion(.failure(APIError.apiKeyNotLoaded))
            return
        }
        
        guard let urlForecast = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=\(apiKey)") else { return }
        
        let sessionForecast = URLSession.shared.dataTask(with: URLRequest(url: urlForecast)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let hourlyForecastStructure = try JSONDecoder().decode(DailyForecastAPI.DailyForecastStructure.self, from: data)
                    completion(.success(hourlyForecastStructure))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        sessionForecast.resume()
    }

    func loadDailyForecast(city: String, completion: @escaping (Result<DailyForecastAPI.DailyForecastStructure, Error>) -> Void) {
        
        guard let apiKey = apiKey else {
            completion(.failure(APIError.apiKeyNotLoaded))
            return
        }
        
        guard let urlForecast = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=\(apiKey)") else { return }
        
        let sessionForecast = URLSession.shared.dataTask(with: URLRequest(url: urlForecast)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let dailyForecastStructure = try JSONDecoder().decode(DailyForecastAPI.DailyForecastStructure.self, from: data)
                    completion(.success(dailyForecastStructure))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        sessionForecast.resume()
    }
    
}

enum APIError: Error {
    case apiKeyNotLoaded
}

