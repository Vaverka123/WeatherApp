//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Vera Maslava on 10.01.24.
//

import Foundation

enum WeatherIconMapping {
    
    static func sfSymbolForOpenWeatherMapIcon(icon: String) -> String {
       
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n", "04d", "04n":
            return "cloud.fill"
        case "09d", "09n":
            return "cloud.heavyrain.fill"
        case "10d":
            return "cloud.sun.rain.fill"
        case "10n":
            return "cloud.moon.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "13d", "13n":
            return "cloud.snow.fill"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }
}
