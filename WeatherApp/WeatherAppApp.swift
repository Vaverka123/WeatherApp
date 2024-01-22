//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Vera Maslava on 4.01.24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @StateObject private var cityManager = CityManager()
    
    var body: some Scene {
        WindowGroup {
            ChooseCityView().environmentObject(cityManager)
        }
    }
}
