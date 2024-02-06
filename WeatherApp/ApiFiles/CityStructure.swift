////
////  CityStructure.swift
////  WeatherApp
////
////  Created by Vera Maslava on 17.01.24.
////
//
//import Foundation
//
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let cityStructure = try? JSONDecoder().decode(CityStructure.self, from: jsonData)
//
//import Foundation
//
//// MARK: - CityStructureElement
//struct CityStructureElement: Codable, Identifiable {
//    let id = UUID()
//    let name: String?
//    let localNames: [String: String]?
//    let lat, lon: Double?
//    let country, state: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case localNames = "local_names"
//        case lat, lon, country, state
//    }
//}
//
//typealias CityStructure = [CityStructureElement]

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityStructure = try? JSONDecoder().decode(CityStructure.self, from: jsonData)

import Foundation

// MARK: - CityStructureElement
struct CityStructureElement: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let localNames: LocalNames?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let el, fr, ja, ru: String?
    let oc, mk: String?
}

typealias CityStructure = [String: CityStructureElement]
