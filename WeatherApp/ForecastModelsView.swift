//
//  ForecastModelsView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 19/01/2024.
//

import SwiftUI


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
                        .font(.system(size: 60, weight: .medium))
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
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundStyle(.white)
            Image(systemName: WeatherIconMapping.sfSymbolForOpenWeatherMapIcon(icon: icon))
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
            Text("\(temperature)°C")
                        .font(.system(size: 30, weight: .medium))
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

