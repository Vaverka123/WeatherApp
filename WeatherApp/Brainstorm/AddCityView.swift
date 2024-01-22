////
////  AddCityView.swift
////  WeatherApp
////
////  Created by Vera Maslava on 16.01.24.
////
//
//import SwiftUI
//import SwiftLocation
//
//struct AddCityView: View {
//    
//    @Environment(\.presentationMode) var presentationMode
//    @State private var userInput: String = ""
//    @State private var suggestedCities: [Location] = []
//    @State private var isCityNotFound: Bool = false
//    
//  //  private let locationManager = LocationManager()
//    
//    var body: some View {
//        ZStack {
//            ContainerRelativeShape()
//                .fill(Color.cyan.gradient)
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading) {
//                
//                HStack {
//                    Button(action: {}) {
//                        Image(systemName: "arrow.left" )
//                        
//                            .padding(.leading)
//                        
//                    }
//                    .accessibilityLabel("back")
//                    .foregroundStyle(.white)
//                    .padding()
//                    Text("Add new city")
//                        .foregroundStyle(.white)
//                }
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.gray)
//                        .padding(.leading, 8)
//                    
//                    TextField("Search", text: $userInput,
//                              onEditingChanged: { _ in
//                       
//                        SwiftLocation(fromAddress: userInput) { result in
//                                                   switch result {
//                                                   case .success(let locations):
//                                                       suggestedCities = locations
//                                                   case .failure(let error):
//                                                       print("Error: \(error)")
//                                                       suggestedCities = []
//                                                   }
//                                               }
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        // Fetch autocomplete suggestions based on user input
////                            locationManager.searchByString(userInput) { (locations, error) in
////                                if let locations = locations {
////                                    suggestedCities = locations
////                                    
////                                } else {
////                                            
////                                    suggestedCities = []
////                                                    }
//                                                }
////                        let filteredInput = userInput.filter { $0.isLetter }
////                        userInput = filteredInput
////                        //    } {
////                        //newValue in
////                        // Call the API service for autocomplete suggestions
////                        //  fetchAutocompleteCities()
//                        
//                    
//                    )
//                }
//                       .padding(8)
//                        .background(Color(white: 0.9))
//                        .cornerRadius(8)
//                        .padding()
//               
//                List {
//                    ForEach(suggestedCities, id: \.id) { city in
//                        Button(action: {
//                            // Set selected city
//                            self.userInput = city.name ?? ""
//                            // Optionally, you can call the API to fetch additional data for the selected city
//                        }) {
//                            HStack {
//                                Text("\(city.name ?? "")")
//                                Spacer()
//                                
//                                Text("\(city.state ?? ""), \(city.country ?? "")")
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//                
//                if isCityNotFound {
//                    Text("City not found")
//                        .foregroundColor(.white)
//                        .padding()
//                } else {
//                    
//                Button("Select new city") {
//                        // Call the API service with the userInput
//                        //  fetchCityWeather()
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    
//                }
//                Spacer()
//            }
//        }
//        }
//    }
//    
//#Preview {
//    AddCityView()
//}
