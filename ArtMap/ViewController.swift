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

<<<<<<< HEAD
class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
=======
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
>>>>>>> d839b32cab56bad3c71a95c902f9d463d86a0be0
    
    var locationManager: CLLocationManager!
    var marker: Marker?
    
    func setMarkers(){
        marker = Marker()
        var g : [GMSMarker] = (marker?.getList())!
        g[0].map = viewMap
        g[1].map = viewMap
    }
    
    @IBOutlet weak var photoImg: UIImageView!
    
    @IBAction func prepareUserProfile(sender: UITapGestureRecognizer) {
        //if loggato
        if let resultController = storyboard?.instantiateViewControllerWithIdentifier("userInterface") as? UserInfoController{
            presentViewController(resultController, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var viewMap: GMSMapView!
    var placesClient: GMSPlacesClient?
    
    @IBAction func tapPhoto(sender: UITapGestureRecognizer) {
        //Apri nuova finestra
        
    }
    
    
<<<<<<< HEAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap.delegate = self
        setMarkers()
=======
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
>>>>>>> d839b32cab56bad3c71a95c902f9d463d86a0be0
        
       
        // Do any additional setup after loading the view, typically from a nib.
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
<<<<<<< HEAD
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        let infoWindow = NSBundle.mainBundle().loadNibNamed("InfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        infoWindow.image.image = UIImage(named: "marker")
        return infoWindow
    }
=======
>>>>>>> d839b32cab56bad3c71a95c902f9d463d86a0be0
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profile"{
            //CONTROLLO DEL LOG -----------------------------------------------
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

