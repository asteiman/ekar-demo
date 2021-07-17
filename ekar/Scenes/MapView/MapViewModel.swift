//
//  MapViewModel.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var availableVehicles = [MapAnnotation]()
    @Published var response: Vehicle?
    private var cancellable: AnyCancellable?
    
    init() {
        
    }
    
    func loadVehicles() {
        cancellable = VehicleRepository(session: .shared, baseURL: "https://api.carsxe.com")
            .getBy(vin: "JTDZN3EU0E3298500")
            .sink(receiveCompletion: { _ in
                //
        }, receiveValue: { response in
            self.response = response
        })
        
        availableVehicles.append(MapAnnotation(title: nil,
                                               subtitle: nil,
                                               coordinate: .init(latitude: 25.0695998, longitude: 55.1440724)))
        availableVehicles.append(MapAnnotation(title: nil,
                                               subtitle: nil,
                                               coordinate: .init(latitude: 25.0695998, longitude: 55.1430724)))
    }
    
    deinit {
        cancellable = nil
    }
}
