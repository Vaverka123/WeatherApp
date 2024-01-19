//
//  SingleCityView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 17/01/2024.
//

import SwiftUI

struct SingleCityView: View {
    
    let cityName: String
           
    @State private var weatherData: WeatherAPI.WeatherStructure?
    @State private var dailyForecastData: DailyForecastAPI.DailyForecastStructure?
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
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
                            LoadingView()
                        }
                        
                    if let dailyForecastData = dailyForecastData {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(dailyForecastData.list ?? [], id: \.dt) { forecast in
                                    if let date = extractDate(from: forecast.dtTxt ?? ""), let time = extractTime(from: forecast.dtTxt ?? "") {
                                    
                                    DailyForecastView(date: date,
                                                        time: time,
                                                        icon: forecast.weather?.first?.icon ?? "",
                                                        description: forecast.weather?.first?.description ?? "",
                                                        temperature: Int(forecast.main?.tempMax ?? 0))
                                        }
                                }
                            }
                        }
                    }
                                else {
                                    LoadingView()
                        }
                    }
                }
                .onAppear {
                    fetchWeather(for: cityName)
                    fetchHourlyForecast(for: cityName)
                    fetchDailyForecast(for: cityName)
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
            

        struct BackgroundView: View {

                var body: some View {

                    ContainerRelativeShape()
                        .fill(Color.blue.gradient)
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

            var icon: String
            var description: String
            var temperature: Int


                var body: some View {
                    Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .padding(.bottom, 10)
                    Text(description)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
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
            var time: String
            var icon: String
            var description: String
            var temperature: Int
        //    var tempMin: Int
        //    var tempMax: Int

            var body: some View {
                VStack {
                    Text(date)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                    Text(time)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                    Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text(description)
                         .font(.system(size: 12, weight: .medium))
                         .foregroundStyle(.white)
                    Text("\(temperature)°C")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                 
                }
            }
        }

        func extractDate(from dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd.MM"
                return dateFormatter.string(from: date)
               
            } else {
                return nil
            }
        }

        struct LoadingView: View {
            var body: some View {
                Text("Loading...")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundStyle(.white)
            }
        }


//#Preview {
//    SingleCityView(cityName:  )
//}
