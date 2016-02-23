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
import FBSDKLoginKit
import Parse
import ParseUI

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{
    
    private var locationManager: CLLocationManager!
    private var markerController: MarkerController?
    private var userController : UserController?
    private var popview: ArtInfoView!
    
    private var markerFlag = false
    private var userFlag = false
    
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    //private var log = false
    
    private func setMarkers(){
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
    
    
    private func setUsers(){
        userController = UserController()
        
        let query = PFQuery(className:"_User")
        
        do{
            if let tmp : NSArray = try query.findObjects(){
                for usr in tmp{
                    self.userController!.createList(usr as! PFObject)
                }
                
                print(userController?.count())
                
                if PFUser.currentUser() == nil {
                    self.loginLabel.text = ""
                }else{
                    if self.userController?.checkUsername(PFUser.currentUser()!["username"] as! String) == false{
                        self.loginLabel.text = PFUser.currentUser()!["username"] as? String
                    }else{
                        PFUser.logOut()
                    }
                    
                }
                
                
                if self.markerFlag{
                    self.markerController?.linkUser((self.userController?.getList())!)
                }
            }else {
                print("No such users")
            }
        } catch {
            print("Query error")
        }
    }
    
    
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBAction func prepareUserProfile(sender: UITapGestureRecognizer) {
        
        if PFUser.currentUser() == nil{
            
            if let resultController = storyboard?.instantiateViewControllerWithIdentifier("loginInterface") as? LoginViewController{
                resultController.setUserController(userController!)
                presentViewController(resultController, animated: true, completion: nil)
            }
            
        }else{
            
            if let resultController = storyboard?.instantiateViewControllerWithIdentifier("userInterface") as? UserInfoController{
                print(PFUser.currentUser()!["username"])
                print(self.userController?.retrieveByUsername(PFUser.currentUser()!["username"] as! String)?.getUsername())
                resultController.setUserPage((self.userController?.retrieveByUsername(PFUser.currentUser()!["username"] as! String))!)
                presentViewController(resultController, animated: true, completion: nil)
                
            }
        }
        
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("tour")
        viewMap.delegate = self
        viewMap.settings.myLocationButton = true
        viewMap.myLocationEnabled = true;
        setMarkers()
        setUsers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        print(PFUser.currentUser()?["username"])
        if PFUser.currentUser() != nil && userController?.count() != 0{
            if ((userController?.checkUsername(PFUser.currentUser()!["username"] as! String)) == false){
                loginLabel.text = PFUser.currentUser()!["username"] as? String
            }else{
                PFUser.logOut()
            }
        }else{
            loginLabel.text = ""
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        let placesClient = GMSPlacesClient()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 5.0)
        viewMap.camera = camera
        
        locationManager.stopUpdatingLocation()
    }
    
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        
        let tmpimage = markerController?.getMarker(marker)?.getImage()
        popUpView(marker, image: tmpimage!)
        //popview.image.image = markerController!.getImageFromMarker(marker)
        
    }
    
    private func popUpView(marker: GMSMarker, image: UIImage){
        self.popview = ArtInfoView(nibName: "ArtInfoView", bundle: nil)
        if let tmp = markerController?.getMarker(marker)! {
            popview.setInformation(Interactor().retriveDBMarkerInfo(tmp))
        }
        self.popview.showInView(self.view, animated: true, image: image)
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker) -> UIView! {
        let mark = markerController?.getMarker(marker)
        let image = getImage(mark!)
        var infoWindow : CustomInfoWindow = CustomInfoWindow()
        infoWindow.prepareImage(image)
        infoWindow = NSBundle.mainBundle().loadNibNamed("InfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
        
        infoWindow.image.image = image
        
        return infoWindow
    }
    
    private func getImage(marker : Marker) -> UIImage{
        return Interactor().retriveDBMarkerImage(marker)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}

