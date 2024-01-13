////
////  ContentView.swift
////  WeatherApp
////
////  Created by Vera Maslava on 4.01.24.
////
import Foundation
import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    @State private var weatherData: WeatherAPI.WeatherStructure?
    @State private var dailyForecastData: DailyForecastAPI.DailyForecastStructure?
    @State private var weatherIconURL: URL?
    
    var body: some View {
        ZStack {
           BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "London")
                
                if let weatherData = weatherData, let icon = weatherData.weather?.first?.icon {
                       Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                           .symbolRenderingMode(.multicolor)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(width: 80, height: 80)
                           .padding(.bottom, 10)
                   }
               
                if let weatherData = weatherData {
                    
                    MainTempView(temperature: Int(weatherData.main?.temp ?? 0))
                        } else {
                    Text("Loading...")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                }
                
                if let description = weatherData?.weather?.first?.description {
                                     Text(description)
                                         .font(.system(size: 20, weight: .medium))
                                         .foregroundStyle(.white)
                                 } 

                if let hourlyForecastData = dailyForecastData {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(hourlyForecastData.list ?? [], id: \.dt) { forecast in
                              if let time = extractTime(from: forecast.dtTxt ?? "") {
                                HourlyForecastView(time: time,
                                                   icon: forecast.weather?.first?.icon ?? "",
                                                   temperature: Int(forecast.main?.temp ?? 0))
                                    .padding()
                                }
                            }
                        }
                    }
                } else {
                                   Text("Loading...")
                                       .font(.system(size: 20, weight: .medium, design: .default))
                                       .foregroundStyle(.white)
                               }
                                
//                                                Button {
//                                                    isNight.toggle()
//                                                } label: {
//                                                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
//                                                }
//                HStack {
//                        if let dailyForecastData = dailyForecastData {
//                 
//                        ForEach(dailyForecastData.list ?? [], id: \.dt) { forecast in
//                            DailyForecastView(date: forecast.dtTxt ?? "",
//                                              icon: forecast.weather?.first?.icon ?? "",
//                                              temperature: Int(forecast.main?.temp ?? 0))
//                            .padding(.top, 20)
//                        }
//                    }  else {
//                        Text("Loading...")
//                            .font(.system(size: 20, weight: .medium, design: .default))
//                            .foregroundStyle(.white)
//                    }
//                }

            }
        }
        .onAppear {
            fetchWeather()
            fetchHourlyForecast()
            fetchDailyForecast()
        }
    }
    
func fetchWeather() {
    
        let apiManager = APIManager()
        apiManager.loadWeather { result in
            switch result {
            case .success(let weatherStructure):
                DispatchQueue.main.async {
                    self.weatherData = weatherStructure
                    
                    if let icon = weatherStructure.weather?.first?.icon {
                                           self.weatherIconURL = URL(string: "https://openweathermap.org/img/w/\(icon).png")
                                       }
                }
            case .failure(let error):
                print("Error fetching current weather: \(error)")
            }
        }
    }
    
func fetchHourlyForecast() {
    let apiManager = APIManager()
        apiManager.loadHourlyForecast { result in
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

func fetchDailyForecast() {
    let apiManager = APIManager()
        apiManager.loadDailyForecast { result in
        switch result {
            case .success(let dailyForecastStructure):
                DispatchQueue.main.async {
                    self.dailyForecastData = dailyForecastStructure
                }
            case .failure(let error):
                print("Error fetching daily forecast: \(error)")
            }
        }
    }
    
}

struct BackgroundView: View {

        var isNight: Bool

        var body: some View {

            ContainerRelativeShape()
                .fill(isNight ? Color.black.gradient : Color.blue.gradient)
                .ignoresSafeArea()
        }
    }

struct CityTextView: View {

        var cityName: String

        var body: some View {
            Text(cityName)
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundStyle(.white)
                .padding()
        }
    }

struct MainTempView: View {
    
        var temperature: Int

        var body: some View {
                Text("\(temperature)°C")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundStyle(.white)
        }
    }

struct HourlyForecastView: View {
     
    var time = "dt_txt"
    var icon: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(time)
                .font(.system(size: 25, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°C")
                .font(.system(size: 35, weight: .medium))
                .foregroundStyle(.white)
            
        }
    }
}

func extractTime(from dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    } else {
        return nil
    }
}

struct DailyForecastView: View {
    
    @State private var dailyForecastData: DailyForecastAPI.DailyForecastStructure?
    var date: String
    var icon: String
    var temperature: Int

    var body: some View {
        VStack {
            Text(date)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°C")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}
