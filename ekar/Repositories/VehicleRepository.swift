//
//  VehicleRepository.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation
import Combine

protocol VehicleRepositoryProtocol: WebRepository {
    func getBy(vin: String) -> AnyPublisher<Vehicle, GenericError>
}

class VehicleRepository: VehicleRepositoryProtocol {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getBy(vin: String) -> AnyPublisher<Vehicle, GenericError> {
        return call(endpoint: API.vehicle(key: "tha91z6lv_j8u1nv4xs_ilfswb1e3", vin: vin))
            .mapError { _ in
                GenericError.network
            }.eraseToAnyPublisher()
    }
}

extension VehicleRepository {
    enum API {
        case vehicle(key: String, vin: String)
    }
}

extension VehicleRepository.API: APICall {

    var path: String {
        switch self {
        case .vehicle(let key, let vin):
            return "/specs?key=\(key)&vin=\(vin)"
        }
    }

    var method: String {
        switch self {
        case .vehicle:
            return "GET"
        }
    }

    var headers: [String: String]? {
        return nil
    }

    func body() throws -> Data? {
        return nil
    }
}
