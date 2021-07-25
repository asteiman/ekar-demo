//
//  VehicleViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 21/07/2021.
//

import Foundation
import Combine

class VehicleViewModel: ObservableObject {
    
    struct VehicleAttribute: Equatable {
        let imageName: String
        let label: String
    }
    
    @Published var contractSliderValue: Float = 0
    @Published var imagesLoading = true
    @Published var vehicle: Vehicle?
    @Published var vehicleAttributes: [VehicleAttribute] = []
    @Published var prices: [VehicleContract] = []
    @Published var images: [String] = []
    private var disposables = Set<AnyCancellable>()
    private let contractRepository: ContractRepositoryProtocol
    private let imagesRepository: ImagesRepositoryProtocol
    private let vin: String?
    
    init(vehicleRepository: VehicleRepositoryProtocol,
         contractRepository: ContractRepositoryProtocol,
         imagesRepository: ImagesRepositoryProtocol,
         vin: String?) {
        
        self.vin = vin
        self.contractRepository = contractRepository
        self.imagesRepository = imagesRepository
        
        if let vin = vin {
            vehicleRepository.getBy(vin: vin).sink { _ in
                //
            } receiveValue: { vehicle in
                self.vehicle = vehicle
                self.vehicleAttributes = [
                    VehicleAttribute(imageName: "attribute-type", label: vehicle.data.cylinders + " cylinders"),
                    VehicleAttribute(imageName: "attribute-seats", label: vehicle.data.doors + " doors"),
                    VehicleAttribute(imageName: "attribute-gear", label: vehicle.data.type),
                    VehicleAttribute(imageName: "attribute-fuel", label: vehicle.data.fuelType)
                ]
            }
            .store(in: &disposables)
        }
        
        $vehicle.drop(while: { $0 == nil} ).flatMap { vehicle in
            return imagesRepository.getBy(make: vehicle!.data.make, model: vehicle!.data.model)
        }.sink(receiveCompletion: { _ in
        }, receiveValue: { receivedImages in
            self.imagesLoading = false
            self.images = receivedImages
        }).store(in: &disposables)
        
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
