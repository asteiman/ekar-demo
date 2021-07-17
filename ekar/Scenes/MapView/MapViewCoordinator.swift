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
                // we didn't find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
        
        annotationView?.image = UIImage(named: "locationPin")
        
            annotationView?.clusteringIdentifier = "cluster"

            // whether it's a new view or a recycled one, send it back
            return annotationView
       }
}
