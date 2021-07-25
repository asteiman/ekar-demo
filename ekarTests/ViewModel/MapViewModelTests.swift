//
//  MapViewModelTests.swift
//  ekarTests
//
//  Created by Alan Steiman on 25/07/2021.
//

@testable import ekar
import XCTest
import MapKit
import Combine

class MapViewModelTests: XCTestCase {
    
    private var disposables = Set<AnyCancellable>()

    func testInit_Success() {
        let viewModel = MapViewModel(repository: PreviewVehicleRepository())

        let annotations: [MapAnnotation] = [
            MapAnnotation(id: "123", title: "Honda Civic", subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2)),
            MapAnnotation(id: "123", title: "Honda Civic", subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2))
        ]
        
        let exp = expectation(description: "")
        viewModel.$mapAnnotations
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    if value.count == annotations.count && value.first?.id == annotations.first?.id {
                        exp.fulfill()
                    }
                  }).store(in: &disposables)

        wait(for: [exp], timeout: 1.0)
    }
}
