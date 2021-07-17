//
//  MapViewCoordinator.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var mapViewController: MapViewRepresentable
    
    init(_ control: MapViewRepresentable) {
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor
                    annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "carMarker"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        //annotationView?.image = UIImage(named: "locationPin")
        
        annotationView?.clusteringIdentifier = "cluster"
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if !(view.annotation is MKClusterAnnotation) {
            self.mapViewController.isActive = true
            self.mapViewController.selectedAnnotation = view.annotation
        }
    }
}
