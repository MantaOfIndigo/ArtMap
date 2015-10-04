//
//  Marker.swift
//  ArtMap
//
//  Created by Andrea Mantani on 04/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class Marker: NSObject {
    
    var m : GMSMarker?
    
    override init(){
        super.init()
    }
    
    internal func getList() -> [GMSMarker]{
        var tmp = [GMSMarker]()
        m = GMSMarker()
        let d = GMSMarker()
        
        m!.appearAnimation = kGMSMarkerAnimationPop
        m!.infoWindowAnchor = CGPointMake(0.44, 0.45);
        m!.snippet = "stupido"
        m?.position = CLLocationCoordinate2DMake(21.304080, -157.733396)
        tmp.append(m!)
        
        d.appearAnimation = kGMSMarkerAnimationPop
        d.infoWindowAnchor = CGPointMake(0.44, 0.45);
        d.snippet = "ciao"
        d.position = CLLocationCoordinate2DMake(21.357168, -157.857679)
        tmp.append(d)
        return tmp
    }

}
