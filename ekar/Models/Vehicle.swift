//
//  Vehicle.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation

struct Vehicle {
    let vin: String
    let data: VehicleData
    var lat: Double
    var long: Double
}

struct VehicleData: Decodable {
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
    
    init(year: String, make: String, model: String) {
        self.year = year
        self.make = make
        self.model = model
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

extension Vehicle {
    static let dummy = Vehicle(vin: "123", data: VehicleData.dummy, lat: 1, long: 2)
}

extension VehicleData {
    static let dummy = VehicleData(year: "2020", make: "Honda", model: "Civic")
}
