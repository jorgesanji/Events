//
//  MapAnnotation.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    ///
    /// Map annotations
    ///
    /// :param: coordinate event coordinate {latitude, longitude}
    /// :param: title event title
    /// :param: subtitle event subtitle
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
