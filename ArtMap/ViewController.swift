//
//  ViewController.swift
//  ArtMap!
//
//  Created by Andrea Mantani on 25/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
//import GoogleMaps
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit
import Parse
import ParseUI

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, PFLogInViewControllerDelegate{

    var locationManager: CLLocationManager!
    var markerController: MarkerController?
    var userController : UserController?
    var popview: ArtInfoView!
    
    var markerFlag = false
    var userFlag = false
    
    let intrct : Interactor = Interactor()
    var log = false
    
    func setMarkers(){
        markerController = MarkerController()
        
        let query = PFQuery(className:"MainDB")
        query.limit = 900
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        self.markerController!.createList(object).getMarker().map = self.viewMap

                    }
                    
                    self.markerFlag = true
                    if self.markerFlag && self.userFlag{
                        self.markerController?.linkUser((self.userController?.getList())!)
                    }
                }
            } else {
                // Log details of the failure
                print("Error")
            }
        }

    }
    
    
    func setUsers(){
        userController = UserController()
        
        let query = PFQuery(className:"_User")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) users.")
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        self.userController!.createList(object)
                        
                    }
                    
                    self.userFlag = true
                    if self.markerFlag && self.userFlag{
                        self.markerController?.linkUser((self.userController?.getList())!)
                    }
                }
            } else{
                print("Error")
            }
        }
    }

    
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBAction func prepareUserProfile(sender: UITapGestureRecognizer) {
            /**/
            
               if PFUser.currentUser() == nil{
                        /*let loginViewController = PFLogInViewController()
                        loginViewController.delegate = self
                        loginViewController.fields = PFLogInFields.Facebook
                        loginViewController.emailAsUsername = true
                        self.presentViewController(loginViewController, animated: false, completion: nil)*/
                if let resultController = storyboard?.instantiateViewControllerWithIdentifier("loginInterface") as? LoginViewController{
                    resultController.setUserList(userController!)
                    presentViewController(resultController, animated: true, completion: nil)
                }
                
               }else{
                if let resultController = storyboard?.instantiateViewControllerWithIdentifier("userInterface") as? UserInfoController{
                    print(PFUser.currentUser()!["username"])
                    print(self.userController?.retrieveByUsername(PFUser.currentUser()!["username"] as! String)?.getUsername())
                    resultController.setUserPage((self.userController?.retrieveByMail(PFUser.currentUser()!["email"] as! String))!)
                    presentViewController(resultController, animated: true, completion: nil)
                }
            }
    }
   
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBOutlet weak var viewMap: GMSMapView!
    var placesClient: GMSPlacesClient?
    
    @IBAction func tapPhoto(sender: UITapGestureRecognizer) {
        //Apri nuova finestra
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMap.delegate = self
        viewMap.settings.myLocationButton = true
        setMarkers()
        setUsers()
    
       /* if FBSDKAccessToken.currentAccessToken() != nil{
            loginLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("username")
            log = true
            
        }else{
            
        
                }*/


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        if PFUser.currentUser() != nil{
            loginLabel.text = PFUser.currentUser()!["username"] as! String
        }else{
            loginLabel.text = ""
        }

        
        }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        placesClient = GMSPlacesClient()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 5.0)
        viewMap.camera = camera
        
        locationManager.stopUpdatingLocation()
    }
  
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        
        let tmpimage = markerController?.getMarker(marker)?.getImage()
        popUpView(marker, image: tmpimage!)
               //popview.image.image = markerController!.getImageFromMarker(marker)
       
    }
    
    func popUpView(marker: GMSMarker, image: UIImage){
        self.popview = ArtInfoView(nibName: "ArtInfoView", bundle: nil)
        if let tmp = markerController?.getMarker(marker)! {
            popview.setInformation(intrct.retriveDBMarkerInfo(tmp))
        }
        self.popview.showInView(self.view, animated: true, image: image)
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker) -> UIView! {
        let mark = markerController?.getMarker(marker)
        let image = tmp(mark!)
        var infoWindow : CustomInfoWindow = CustomInfoWindow()
        infoWindow.prepareImage(image)
        infoWindow = NSBundle.mainBundle().loadNibNamed("InfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        // devo rendere sincrono sto cazzo di thread altrimenti carica l'immagine dopo che lancia la view
        infoWindow.image.image = image
        
        return infoWindow
    }
    
    func tmp(mark : Marker) -> UIImage{
        return intrct.retriveDBMarkerImage(mark)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  



}

