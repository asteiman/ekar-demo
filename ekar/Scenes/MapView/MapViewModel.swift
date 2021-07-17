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
    private var availableVehicles: [Vehicle] = []
    private var cancellable: AnyCancellable?
    
    init() {
        
    }
    
    func loadVehicles() {
        let vinNumbersToRequest = ["JTDZN3EU0E3298500", "1FDWE37S7WHB57339"]
        var requests = [AnyPublisher<Vehicle, GenericError>]()
        
        vinNumbersToRequest.forEach { vinNumber in
            requests.append(VehicleRepository(session: .shared, baseURL: "https://api.carsxe.com").getBy(vin: vinNumber))
        }
        let downstream = Publishers.MergeMany(requests).collect()
        cancellable = downstream
            .sink(receiveCompletion: { _ in
                self.isLoading = true
        }, receiveValue: { returnedVehicles in
            self.availableVehicles = returnedVehicles
            self.mapAnnotations = returnedVehicles.map({ vehicle in
                MapAnnotation(title: vehicle.make + " " + vehicle.model,
                               subtitle: nil,
                               coordinate: .init(latitude: 25.0695998, longitude: 55.1440724))
            })
        })
        
        mapAnnotations.removeAll()
        mapAnnotations.append(MapAnnotation(title: "test",
                                               subtitle: nil,
                                               coordinate: .init(latitude: 25.0695998, longitude: 55.1440724)))
        mapAnnotations.append(MapAnnotation(title: "test 2",
                                               subtitle: nil,
                                               coordinate: .init(latitude: 25.0695998, longitude: 55.1430724)))
    }
}
