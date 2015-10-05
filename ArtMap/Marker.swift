//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 05/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class Marker: NSObject {
    
    private var marker : GMSMarker
    private var id : Int
    private var image : UIImage
    
    init(position: CLLocationCoordinate2D, id: Int, image: UIImage){
        
        self.marker = GMSMarker()
        self.marker.icon = UIImage(named: "icon")
        self.marker.position = position
        self.marker.appearAnimation = kGMSMarkerAnimationPop
        self.marker.infoWindowAnchor = CGPointMake(0.44, 0.45);
        
        self.image = image
        self.id = id
    }
    func getMarker() -> GMSMarker{
        return self.marker
    }
    func getId() -> Int{
        return self.id
        
    }
    func getImage() -> UIImage{
        return self.image
    }

}
