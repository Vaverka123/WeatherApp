//
//  FavoriteCityView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 19/01/2024.
//

import SwiftUI

struct FavoriteCityView: View {

    @EnvironmentObject var cityManager: CityManager
    
    var body: some View {

        TabView {
            ForEach(cityManager.favoriteCities, id: \.self) { cityName in
                SingleCityView(cityName: cityName)
                    .tabItem {
                        Text(cityName)
                    }
                    .tag(cityName)
            }
            }
        }
    }

    
               
                    
