//
//  Locator.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//
/*
import UIKit
import CoreLocation
import GoogleMaps

class Locator: NSObject, CLLocationManagerDelegate {
    
    private var place: GMSPlacesClient?
    var locationManager: CLLocationManager!
    var camera: GMSCameraPosition?
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getGPSPosition()->GMSCameraPosition?{
        let cam = self.camera
        return cam
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        self.place = GMSPlacesClient()
        let cam: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 8.0)
        camera = cam
        locationManager.stopUpdatingLocation()
        

    }
}
*/