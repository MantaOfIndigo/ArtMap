//
//  ViewController.swift
//  ArtMap!
//
//  Created by Andrea Mantani on 25/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import FBSDKCoreKit

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var locationManager: CLLocationManager!
    var markerController: MarkerController?
    var popview: ArtInfoView!
    
    var log = false
    
    func setMarkers(){
        markerController = MarkerController()
        var g : [Marker] = (markerController?.getMarkerList())!
        g[0].getMarker().map = viewMap
        g[1].getMarker().map = viewMap

    }
    
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBAction func prepareUserProfile(sender: UITapGestureRecognizer) {
        //if loggato
        if !log {
            if let resultController = storyboard?.instantiateViewControllerWithIdentifier("loginInterface") as? LoginViewController{
                presentViewController(resultController, animated: true, completion: nil)
            }
        }else{
            if let resultController = storyboard?.instantiateViewControllerWithIdentifier("userInterface") as? UserInfoController{
                presentViewController(resultController, animated: true, completion: nil)
            }
        }
    }
    @IBOutlet weak var viewMap: GMSMapView!
    var placesClient: GMSPlacesClient?
    
    @IBAction func tapPhoto(sender: UITapGestureRecognizer) {
        //Apri nuova finestra
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMap.delegate = self
        setMarkers()
        
        if FBSDKAccessToken.currentAccessToken() != nil{
            loginLabel.text = "Andrea Mantani"
            log = true
            
        }else{
            loginLabel.text = "Not Logged"
            log = false
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        placesClient = GMSPlacesClient()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 10.0)
        viewMap.camera = camera
        
        locationManager.stopUpdatingLocation()
    }
  
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        
        self.popview = ArtInfoView(nibName: "ArtInfoView", bundle: nil)
        
        if let tmp = markerController?.getMarker(marker)! {
            popview.setInformation(tmp)
        }
               //popview.image.image = markerController!.getImageFromMarker(marker)
        self.popview.showInView(self.view, animated: true, image: (markerController?.getImageFromMarker(marker))!)
    }
    
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker) -> UIView! {
        let infoWindow = NSBundle.mainBundle().loadNibNamed("InfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        infoWindow.image.image = markerController!.getImageFromMarker(marker)
        return infoWindow
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("diocane")
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

