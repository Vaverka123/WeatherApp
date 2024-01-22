//
//  ChooseCityView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 19/01/2024.
//

import SwiftUI

struct ChooseCityView: View {
    
        @EnvironmentObject var cityManager: CityManager
    
        let capitals = ["Paris", "Berlin", "Madrid", "Rome", "London", "Amsterdam", "Lisbon"]

        var body: some View {
            
            NavigationView {
                VStack {
                    NavigationLink(destination: FavoriteCityView()) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.white)
                            Text("View Favorite Cities")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                   
  
                    ScrollView {
                        ForEach(capitals, id: \.self) { capital in
                            NavigationLink(destination: SingleCityView(cityName: capital)) {
                                Text(capital)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .navigationTitle("Available cities")
                
            }
        }
    }


