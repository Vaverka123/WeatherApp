////
////  AddCityByApiView.swift
////  WeatherApp
////
////  Created by Vera Maslava on 18/01/2024.
////
//// add to APIManager:  
////func loadCityName(for userInput: String, completion: @escaping (Result<CityStructure, Error>) -> Void) {
////// {city name},{state code},{country code}
////guard let urlCity = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(userInput)&limit=20&appid=aadf014bb0e02cab417fb007f23b93d4") else { return }
////
////let sessionCity = URLSession.shared.dataTask(with: URLRequest(url: urlCity)) { data, response, error in
////  if let error {
////      completion(.failure(error))
////  } else if let data = data {
////      do {
////          let cityStructure = try JSONDecoder().decode(CityStructure.self, from: data)
////          completion(.success(cityStructure))
////      } catch {
////          completion(.failure(error))
////      }
////  }
////}
////
////sessionCity.resume()
////}
//
//
//
//
//import SwiftUI
//
//struct AddCityByApiView: View {
//    
//    @Environment(\.presentationMode) var presentationMode
//    @State private var userInput: String = ""
//    @State private var cityData: CityStructure?
//    @State private var suggestedCities: [CityStructureElement] = []
//    @State private var isCityNotFound: Bool = false
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
//                                
//                                    .padding(.leading)
//                                
//                            }
//                            .accessibilityLabel("back")
//                            .foregroundStyle(.white)
//                            .padding()
//                            Text("Add new city")
//                                .foregroundStyle(.white)
//                        }
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                                .padding(.leading, 8)
//                            
//                            TextField("Search", text: $userInput,
//                                onEditingChanged: { _ in
//                                    // Validate the input to allow only letters in the Latin alphabet
//                                    let filteredInput = userInput.filter { $0.isLetter }
//                                    userInput = filteredInput
//                            //    } {
//                                    //newValue in
//                                    // Call the API service for autocomplete suggestions
//                                    //  fetchAutocompleteCities()
////                                    if userInput == "Default" {
////                                        fetchAutocompleteCities(to: nil)
////                                    } else {
////                                        fetchAutocompleteCities(to: userInput)
////                                    }
//                                })
//                               .padding(8)
//                                .background(Color(white: 0.9))
//                                .cornerRadius(8)
//                                .padding()
//                        }
//                            
//                        
//                        List {
//                            ForEach(suggestedCities, id: \.id) { city in
//                                Button(action: {
//                                    // Set selected city
//                                    self.userInput = city.name ?? ""
//                                    // Optionally, you can call the API to fetch additional data for the selected city
//                                }) {
//                                    HStack {
//                                        Text("\(city.name ?? "")")
//                                        Spacer()
//                                        
//                                        Text("\(city.state ?? ""), \(city.country ?? "")")
//                                            .foregroundColor(.gray)
//                                    }
//                                }
//                            }
//                        }
//                        .listStyle(PlainListStyle())
//                        
//                        if isCityNotFound {
//                            Text("City not found")
//                                .foregroundColor(.white)
//                                .padding()
//                        } else {
//                            
//                            Button("Select new city") {
//                                // Call the API service with the userInput
//                                //  fetchCityName()
//                            }
//                            .foregroundStyle(.white)
//                            .padding()
//                            
//                        }
//                    }
//                    Spacer()
//                }
//            }
//        }
//
//
//
//#Preview {
//    AddCityByApiView()
//}
