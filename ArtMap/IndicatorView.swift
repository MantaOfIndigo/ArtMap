//
//  IndicatorView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 20/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import MapKit

protocol IndicatorView{
    func addOverlay(polyline : MKPolyline, boundingRegion: MKMapRect, steps : [Step])
}
