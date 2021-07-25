//
//  MapViewRepresentable.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    var annotations: [MapAnnotation]
    @Binding var isActive: Bool
    @Binding var selectedAnnotation: MapAnnotation?
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 25.0709248, longitude: 55.1429923)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region =
            MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.removeAnnotations(annotations)
        view.addAnnotations(annotations)
    }
}
