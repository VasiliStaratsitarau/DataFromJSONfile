//
//  CityData.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import Foundation

struct CityData: Codable {
    var country: String
    var name: String
    var _id: Int
    let coord: Coord
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
//{"country":"UA","name":"Hurzuf","_id":707860,"coord":{"lon":34.283333,"lat":44.549999}}
