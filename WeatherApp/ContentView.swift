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
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "London")
                
                if let weatherData = weatherData {
                    MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "sun.max.fill", temperature: Int(weatherData.main?.temp ?? 0))
                } else {
                    Text("Loading...")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                }
                

                HStack (spacing: 15) {
                                   WeatherDayView(dayOfWeek: "TUE",
                                                  imageName:  "cloud.sun.fill",
                                                  temperature: 274)
                                   WeatherDayView(dayOfWeek: "WED",
                                                  imageName: "sun.max.fill",
                                                  temperature: 280)
                                   WeatherDayView(dayOfWeek: "THU",
                                                  imageName: "wind.snow",
                                                  temperature: 260)
                                   WeatherDayView(dayOfWeek: "FRI",
                                                  imageName: "cloud.sleet",
                                                  temperature: 274)
                                   WeatherDayView(dayOfWeek: "SAT",
                                                  imageName: "cloud.sun.fill",
                                                  temperature: 265)
                               }
                    
                    
                Spacer()
                
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

struct MainWeatherStatusView: View {

        var imageName: String
        var temperature: Int

        var body: some View {


            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                Text("\(temperature)°C")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundStyle(.white)

            }
            .padding(.bottom, 40)
        }
    }

struct WeatherDayView: View {

        var dayOfWeek: String
        var imageName: String
        var temperature: Int

        var body: some View {
            VStack {
                Text(dayOfWeek)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundStyle(.white)
                Image(systemName: imageName)
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
