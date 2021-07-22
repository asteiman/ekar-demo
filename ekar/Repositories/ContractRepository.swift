//
//  ContractRepository.swift
//  ekar
//
//  Created by Alan Steiman on 22/07/2021.
//

import Foundation

protocol ContractRepositoryProtocol {
    func getBy(vin: String?) -> [VehicleContract]
}

class ContractRepository: ContractRepositoryProtocol {
    func getBy(vin: String?) -> [VehicleContract] {
        return [
            VehicleContract(month: 1, price: 1500),
            VehicleContract(month: 3, price: 1400),
            VehicleContract(month: 6, price: 1300),
            VehicleContract(month: 9, price: 1200)
        ]
    }
}
