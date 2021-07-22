//
//  VehicleViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 21/07/2021.
//

import Foundation
import Combine

class VehicleViewModel: ObservableObject {
    
    @Published var contractSliderValue: Float = 0
    @Published var isLoading = true
    @Published var vehicle: Vehicle?
    @Published var prices: [VehicleContract] = []
    private var disposables = Set<AnyCancellable>()
    private let contractRepository: ContractRepositoryProtocol
    private let vin: String?
    
    init(vehicleRepository: VehicleRepositoryProtocol, contractRepository: ContractRepositoryProtocol, vin: String?) {
        
        self.vin = vin
        self.contractRepository = contractRepository
        
        if let vin = vin {
            vehicleRepository.getBy(vin: vin).sink { _ in
                self.isLoading = false
            } receiveValue: { vehicle in
                self.vehicle = vehicle
            }
            .store(in: &disposables)
        }
        
        $contractSliderValue
          .dropFirst(1)
            .sink(receiveValue: calculateContract(duration:))
          .store(in: &disposables)
    }
    
    private func calculateContract(duration: Float) {
        prices = contractRepository.getBy(vin: vin)
    }
    
    func getMinMonths() -> Int {
        return prices.first?.month ?? 0
    }
    
    func getMaxMonths() -> Int {
        return prices.last?.month ?? 0
    }
}
