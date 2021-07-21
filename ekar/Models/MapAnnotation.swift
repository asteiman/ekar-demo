//
//  MapAnnotation.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(id: String, title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
