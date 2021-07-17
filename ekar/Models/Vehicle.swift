//
//  Vehicle.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation

struct Vehicle: Decodable {
    let year: String
    let make: String
    let model: String
    
    enum OuterKeys: String, CodingKey {
        case deepdata
    }
    
    enum DeepDataKeys: String, CodingKey {
        case make = "Make"
        case model = "Model"
        case year = "Model Year"
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let deepDataContainer = try outerContainer.nestedContainer(keyedBy: DeepDataKeys.self,
                                                                  forKey: .deepdata)

        self.make = try deepDataContainer.decode(String.self, forKey: .make)
        self.model = try deepDataContainer.decode(String.self, forKey: .model)
        self.year = try deepDataContainer.decode(String.self, forKey: .year)
    }
}
