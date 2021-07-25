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
    @Published var mapAnnotations = [MapAnnotation]()
    @Published var isLoading = false
    private var cancellable: AnyCancellable?
    let repository: VehicleRepositoryProtocol
    
    init(repository: VehicleRepositoryProtocol) {
        self.repository = repository
        self.loadVehicles()
    }
    
    private func loadVehicles() {
        isLoading = true
        // Vin numbers hardcoded for simplicity
        let vinNumbersToRequest = ["JTDZN3EU0E3298500", "2HGEJ6675VH583695"]
        var requests = [AnyPublisher<Vehicle, GenericError>]()
        
        vinNumbersToRequest.forEach { vinNumber in
            requests.append(
                self.repository.getBy(vin: vinNumber)
            )
        }
        
        // Parallels requests
        let downstream = Publishers.MergeMany(requests).collect()
        
        cancellable = downstream
            .sink(receiveCompletion: { _ in
                self.isLoading = false
        }, receiveValue: { returnedVehicles in
            self.mapAnnotations = returnedVehicles.map({ vehicle in
                MapAnnotation(id: vehicle.vin, title: vehicle.data.make + " " + vehicle.data.model,
                               subtitle: nil,
                               coordinate: .init(latitude: vehicle.lat, longitude: vehicle.long))
            })
        })
    }
}
