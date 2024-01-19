//
//  ChooseCityView.swift
//  WeatherApp
//
//  Created by Vera Maslava on 19/01/2024.
//

import SwiftUI

struct ChooseCityView: View {
    
        let europeanCapitals = ["Paris", "Berlin", "Madrid", "Rome", "London", "Amsterdam", "Lisbon"]

        var body: some View {
            NavigationView {
                ScrollView {
                    ForEach(europeanCapitals, id: \.self) { capital in
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
                .navigationTitle("European Capitals")
            }
        }
    }

   
//    let capitals = ["Warsaw", "London", "Lisbon", "Paris", "Berlin"]
// 
//    
//    var body: some View {
//        
//                ZStack {
//                    ContainerRelativeShape()
//                        .fill(Color.cyan.gradient)
//                        .ignoresSafeArea()
//        
//                    VStack(alignment: .leading) {
//                        
//                        HStack {
//                            Button(action: {}) {
//                                Image(systemName: "arrow.left" )
//                                    .padding(.leading)
//                            }
//                            .accessibilityLabel("back")
//                            .foregroundStyle(.white)
//                            .padding()
//                            
//                            Text("Add new city")
//                                .foregroundStyle(.white)
//                        }
//                        
//                        HStack {
//                            
//                            
//                            
//                            
//                        }
//                        .padding(8)
//                        .background(Color(white: 0.9))
//                        .cornerRadius(8)
//                        .padding()
//                        
//                    }
//                     
//                    }
//    }
//}
                                      
#Preview {
    ChooseCityView()
}
