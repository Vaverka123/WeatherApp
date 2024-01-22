////
////  API.swift
////  WeatherApp
////
////  Created by Vera Maslava on 8.01.24.
////

import Foundation


final class APIManager {
   
    let apiKey = "aadf014bb0e02cab417fb007f23b93d4"
    
    func loadWeather(city: String, completion: @escaping (Result <WeatherAPI.WeatherStructure, Error>) -> Void) {
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

