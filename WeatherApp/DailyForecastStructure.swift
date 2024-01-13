// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dailyForecastStructure = try? JSONDecoder().decode(DailyForecastStructure.self, from: jsonData)

import Foundation

enum DailyForecastAPI {
    // MARK: - DailyForecastStructure
    struct DailyForecastStructure: Codable {
        let cod: String?
        let message, cnt: Int?
        let list: [List]?
        let city: City?
    }
    
    // MARK: - City
    struct City: Codable {
        let id: Int?
        let name: String?
        let coord: Coord?
        let country: String?
        let population, timezone, sunrise, sunset: Int?
    }
    
    // MARK: - Coord
    struct Coord: Codable {
        let lat, lon: Double?
    }
    
    // MARK: - List
    struct List: Codable {
        let dt: Int?
        let main: MainClass?
        let weather: [Weather]?
        let clouds: Clouds?
        let wind: Wind?
        let visibility: Int?
        let pop: Double?
        let sys: Sys?
        let dtTxt: String?
        let snow: Snow?
        
        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
            case snow
        }
    }
    
    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int?
    }
    
    // MARK: - MainClass
    struct MainClass: Codable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, seaLevel, grndLevel, humidity: Int?
        let tempKf: Double?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }
    
    // MARK: - Snow
    struct Snow: Codable {
        let the3H: Double?
        
        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let pod: Pod?
    }
    
    enum Pod: String, Codable {
        case d = "d"
        case n = "n"
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int?
        let main: MainEnum?
        let description: String?
        let icon: String?
    }
    
//    enum Description: String, Codable {
//        case brokenClouds = "broken clouds"
//        case clearSky = "clear sky"
//        case fewClouds = "few clouds"
//        case lightSnow = "light snow"
//        case overcastClouds = "overcast clouds"
//        case scatteredClouds = "scattered clouds"
//        case showerRain = "shower rain"
//        case rain = "rain"
//        case snow = "snow"
//        case mist = "mist"
//        case thunderstorm =  "thunderstorm"
//    }
//    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case snow = "Snow"
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
}
