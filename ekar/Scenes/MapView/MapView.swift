//
//  mapView.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        MapViewRepresentable(annotations: viewModel.availableVehicles)
            .onAppear(perform: {
                viewModel.loadVehicles()
            })
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    
    var annotations: [MapAnnotation]
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context){
        
        let coordinate = CLLocationCoordinate2D(
                    latitude: 25.0709248, longitude: 55.1429923)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region =
                    MKCoordinateRegion(center: coordinate, span: span)
                view.setRegion(region, animated: true)
        
        view.delegate = context.coordinator
        view.removeAnnotations(annotations)
        view.addAnnotations(annotations)
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel())
    }
}
