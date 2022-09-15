//
//  CityData.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import Foundation

struct CityData: Codable {
    let country: String
    let name: String
    let id: Int
    var coord: Coord
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coord
    }
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

