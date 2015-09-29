//
//  Locator.swift
//  ArtMap!
//
//  Created by Andrea Mantani on 28/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import CoreLocation

class Locator: NSObject, CLLocationManagerDelegate {
    // ATTRIBUTO LOCATOR ---------------------------------------------
    var locationManager:CLLocationManager = CLLocationManager()
    // COSTRUTTORI ---------------------------------------------------
    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
    }
    
    func locationManager(manger: CLLocationManager!, didChangeAuthoricationStatus status: CLAuthorizationStatus){
        
        print("didChangeAuthoricationStatus")
        
        switch status{
        case .NotDetermined:
            print(".NotDetermined")
            break
            
        case .Authorized:
            print(".Authorized")
            break
        case .Denied:
            print(".Denied")
            break
        default:
            print("Unhandled authorization status")
            break
        }
    }
    
}
