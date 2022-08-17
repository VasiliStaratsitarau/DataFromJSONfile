//
//  DataLoader.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 09/08/2022.
//

import Foundation

public class DataLoader {
    
    @Published var cityData = [CityData]()
    
    init() {
        load()
    }
    
    func load() {
        if let filelocation = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: filelocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([CityData].self, from: data)
                self.cityData = dataFromJson
            } catch {
                print(error)
            }
        }
    }
}
