//
//  PreviewVehicleRepository.swift
//  ekar
//
//  Created by Alan Steiman on 21/07/2021.
//

import Foundation
import Combine

class PreviewVehicleRepository: VehicleRepositoryProtocol {
    func getBy(vin: String) -> AnyPublisher<Vehicle, GenericError> {
        return Just(Vehicle.dummy).setFailureType(to: GenericError.self).eraseToAnyPublisher()
    }
    
    var session: URLSession = .shared
    
    var baseURL: String = ""
    
    var bgQueue: DispatchQueue = DispatchQueue(label: "")
}
