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

enum LocatorErrors: Int{
    case AuthorizationDenied
    case AuthorizationNotDetermined
    case InvalidLocation
}

class Locator: NSObject, CLLocationManagerDelegate {
    // ATTRIBUTO LOCATOR ---------------------------------------------
    var locationManager:CLLocationManager?
    
    //DISTRUTTORE ----------------------------------------------------
    deinit{
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    typealias LocationClosure = ((location: CLLocation?, error: NSError?)->())
    private var didComplete: LocationClosure?
    
    private func _didComplete(location: CLLocation?, error: NSError?){
        locationManager?.stopUpdatingLocation()
        didComplete?(location: location, error: error)
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    func locationManager(manger: CLLocationManager!, didChangeAuthoricationStatus status: CLAuthorizationStatus){
        
        switch status{
        case .AuthorizedWhenInUse:
            self.locationManager!.startUpdatingLocation()
        case .Denied:
            _didComplete(nil, error: NSError(domain: self.classForCoder.description(), code: LocatorErrors.AuthorizationDenied.rawValue, userInfo: nil))
        default:
            break
        }
    }
    
    internal func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        _didComplete(nil, error: error)
    }
    internal func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations[0] as? CLLocation{
            _didComplete(location, error: nil)
        } else {
            _didComplete(nil, error: NSError(domain: self.classForCoder.description(),
                code: LocatorErrors.InvalidLocation.rawValue,
                userInfo: nil))

        }
        
    }
    
    func fetchWithCompletion(completion: LocationClosure){
        didComplete = completion
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        if(NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationWhenInUseUsageDescription") != nil){
            locationManager!.requestWhenInUseAuthorization()
        } else if(NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil){
            locationManager!.requestAlwaysAuthorization()
        } else {
            fatalError("Per usare la locazione in iOS8 occorre defiire  NSLocationWhenInUseUsageDescription o NSLocationAlwaysUsageDescription nei bundle dell'app nel file Info.plist")
        }
    }
    
}
*/
