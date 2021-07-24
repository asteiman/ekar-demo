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

struct VehicleContract {
    let month: Int
    let price: Float
}

struct VehicleData: Decodable {
    let year: String
    let make: String
    let model: String
    let doors: String
    let type: String
    let fuelType: String
    let cylinders: String
    let features: [String]
    let colors = ["red", "blue"]
    
    enum OuterKeys: String, CodingKey {
        case deepdata
        case attributes
    }
    
    enum AttributesKeys: String, CodingKey {
        case doors = "doors"
        case type = "type"
        case fuelType = "fuel_type"
        case cylinders = "engine_cylinders"
    }
    
    enum DeepDataKeys: String, CodingKey {
        case make = "Make"
        case model = "Model"
        case year = "Model Year"
    }
    
    init(year: String, make: String, model: String, doors: String, type: String, fuelType: String, cylinders: String, features: [String]) {
        self.year = year
        self.make = make
        self.model = model
        self.doors = doors
        self.type = type
        self.fuelType = fuelType
        self.cylinders = cylinders
        self.features = features
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let deepDataContainer = try outerContainer.nestedContainer(keyedBy: DeepDataKeys.self,
                                                                  forKey: .deepdata)
        let attributesContainer = try outerContainer.nestedContainer(keyedBy: AttributesKeys.self,
                                                                     forKey: .attributes)

        self.make = try deepDataContainer.decode(String.self, forKey: .make)
        self.model = try deepDataContainer.decode(String.self, forKey: .model)
        self.year = try deepDataContainer.decode(String.self, forKey: .year)
        
        self.doors = try attributesContainer.decode(String.self, forKey: .doors)
        self.type = try attributesContainer.decode(String.self, forKey: .type)
        self.fuelType = try attributesContainer.decode(String.self, forKey: .fuelType)
        self.cylinders = try attributesContainer.decode(String.self, forKey: .cylinders)
        self.features = ["Keyless Entry", "Bluetooth", "Power Windows", "ABS Breakes with EDB", "AUX / USB Jack", "AM / FM"]
    }
}

extension Vehicle {
    static let dummy = Vehicle(vin: "123", data: VehicleData.dummy, lat: 1, long: 2)
}

extension VehicleData {
    static let dummy = VehicleData(
        year: "2020",
        make: "Honda",
        model: "Civic",
        doors: "5",
        type: "Wagon",
        fuelType: "Petrol",
        cylinders: "4",
        features: ["Keyless Entry", "Bluetooth", "Power Windows", "ABS Breakes with EDB", "AUX / USB Jack", "AM / FM"]
    )
}
