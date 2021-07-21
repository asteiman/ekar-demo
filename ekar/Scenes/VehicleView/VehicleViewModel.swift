//
//  VehicleViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 21/07/2021.
//

import Foundation
import Combine

class VehicleViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var vehicle: Vehicle?
    private var cancellable: AnyCancellable?
    
    init(repository: VehicleRepositoryProtocol, vin: String?) {
        if let vin = vin {
            cancellable = repository.getBy(vin: vin).sink { _ in
                self.isLoading = false
            } receiveValue: { vehicle in
                self.vehicle = vehicle
            }
        }
    }
    
    deinit {
        cancellable = nil
    }
}
