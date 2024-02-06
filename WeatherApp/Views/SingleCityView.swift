//
//  SingleCityView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 17/01/2024.
//

import SwiftUI

struct SingleCityView: View {
    
    let cityName: String
    @EnvironmentObject var cityManager: CityManager

    @State private var showToggleFavoriteButton = false
    @State private var weatherData: WeatherAPI.WeatherStructure?
    @State private var dailyForecastData: DailyForecastAPI.DailyForecastStructure?
    
   private var isFavorite: Bool { cityManager.favoriteCities.contains(cityName) }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                
                if showToggleFavoriteButton {
                    Button(action: { toggleFavorite() }) {
                        
                        HStack {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                            Text(isFavorite ? "Remove from favorites" : "Add to favorites")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
                    CityTextView(cityName: cityName)
                       
                    if let weatherData = weatherData, let icon = weatherData.weather?.first?.icon, let description = weatherData.weather?.first?.description {
                            MainTempView(icon: icon, description: description, temperature: Int(weatherData.main?.temp ?? 0))
                       
                        } else {
                            LoadingView()
                        }
                        
                    if let hourlyForecastData = dailyForecastData {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(hourlyForecastData.list ?? [], id: \.dt) { forecast in
                                        if let time = formatDate(from: forecast.dtTxt ?? "", format: "HH:mm") {
                                            HourlyForecastView(time: time,
                                                               icon: forecast.weather?.first?.icon ?? "",
                                                               temperature: Int(forecast.main?.temp ?? 0))
                                        }
                                    }
                                }
                            }
                        } else {
                            LoadingView()
                        }
                        
                    if let dailyForecastData = dailyForecastData {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(dailyForecastData.list ?? [], id: \.dt) { forecast in
                                    if let date = formatDate(from: forecast.dtTxt ?? "", format: "dd.MM"),
                                        let time = formatDate(from: forecast.dtTxt ?? "", format: "HH:mm") {
                                    
                                    DailyForecastView(date: date,
                                                        time: time,
                                                        icon: forecast.weather?.first?.icon ?? "",
                                                        description: forecast.weather?.first?.description ?? "",
                                                        temperature: Int(forecast.main?.tempMax ?? 0))
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                                else {
                                    LoadingView()
                        }
                    }
                    .padding(.bottom, 40)
                }
                .onAppear {
                    showToggleFavoriteButton = true
                    fetchWeather(for: cityName)
                    fetchHourlyForecast(for: cityName)
                    fetchDailyForecast(for: cityName)
                }
            }
    
    
    private func toggleFavorite() {
        if isFavorite {
            cityManager.favoriteCities.removeAll { $0 == cityName }
        } else {
            cityManager.favoriteCities.append(cityName)
            }
        
        }
    
            
        func fetchWeather(for city: String) {
            let apiManager = APIManager()
                apiManager.loadWeather(city: city) { result in
                    switch result {
                    case .success(let weatherStructure):
                        DispatchQueue.main.async {
                            self.weatherData = weatherStructure
                       }
                    case .failure(let error):
                        print("Error fetching current weather: \(error)")
                    }
                }
            }
            
        func fetchHourlyForecast(for city: String) {
            let apiManager = APIManager()
                apiManager.loadHourlyForecast(city: city) { result in
                    switch result {
                    case .success(let hourlyForecastStructure):
                        DispatchQueue.main.async {
                            self.dailyForecastData = hourlyForecastStructure
                        }
                    case .failure(let error):
                        print("Error fetching hourly forecast: \(error)")
                        
                    }
                }
            }
            
        func fetchDailyForecast(for city: String) {
            let apiManager = APIManager()
                apiManager.loadDailyForecast(city: city) { result in
                    switch result {
                    case .success(let dailyForecastStructure):
                        DispatchQueue.main.async {
                            self.dailyForecastData = dailyForecastStructure
                        }
                    case .failure(let error):
                        print("Error fetching hourly forecast: \(error)")
                        
                    }
                }
            }
        }
            
