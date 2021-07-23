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
    
    func getMonthlyFee() -> Float {
        return prices.first(where: { contract in
            contract.month == getSelectedMonth()
        })?.price ?? 0
    }
    
    func getSelectedMonth() -> Int {
        return contractSliderValue == 0 ? 1 : Int(contractSliderValue)
    }
    
    func getSavingsAmount() -> Float {
        guard contractSliderValue != 0 else { return 0 }
        guard let firstMonthlyFee = prices.first?.price else { return 0 }

        let currentMonthlyFee = getMonthlyFee()
        let diff = firstMonthlyFee - currentMonthlyFee
        return diff * contractSliderValue
    }
}
