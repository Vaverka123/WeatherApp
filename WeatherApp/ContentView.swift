////
////  ContentView.swift
////  WeatherApp
////
////  Created by Vera Maslava on 4.01.24.
////
import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    @State private var weatherData: WeatherStructure?
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
                

//                HStack (spacing: 15) {
//                                   WeatherDayView(dayOfWeek: "TUE",
//                                                  icon: "cloud.sun.fill",
//                                                  temperature: 274)
//                                   WeatherDayView(dayOfWeek: "WED",
//                                                  icon: "sun.max.fill",
//                                                  temperature: 280)
//                                   WeatherDayView(dayOfWeek: "THU",
//                                                  icon: "wind.snow",
//                                                  temperature: 260)
//                                   WeatherDayView(dayOfWeek: "FRI",
//                                                  icon: "cloud.sleet",
//                                                  temperature: 274)
//                                   WeatherDayView(dayOfWeek: "SAT",
//                                                  icon: "cloud.sun.fill",
//                                                  temperature: 265)
//                               }
//                    
//                    
//                Spacer()
                
                                                Button {
                                                    isNight.toggle()
                                                } label: {
                                                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                                                }
                                
                                                Spacer()
            }
        }
        .onAppear {
            fetchWeather()
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
                print("Error: \(error)")
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

struct WeatherDayView: View {

        var dayOfWeek: String
        var icon: String
        var temperature: Int

        var body: some View {
            VStack {
                Text(dayOfWeek)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundStyle(.white)
                Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("\(temperature)°")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
    }
