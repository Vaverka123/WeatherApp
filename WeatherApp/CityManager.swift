//
//  CityManager.swift
//  WeatherApp
//
//  Created by Vera Maslava on 22/01/2024.
//

import Combine

class CityManager: ObservableObject {
    @Published var favoriteCities: [String] = []
}
