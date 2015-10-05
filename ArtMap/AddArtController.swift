//
//  AddArtController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//


import UIKit
import GoogleMaps
import MobileCoreServices

class AddArtController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    var newMedia: Bool?
    var imagePicker: UIImagePickerController!
    var locationManager : CLLocationManager?
    
    @IBOutlet weak var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var tapImage: UITapGestureRecognizer!

    
    @IBOutlet weak var addCameraImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        addCameraImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton{
            //Crea nuovo oggetto Art e invialo
        }
        
        locationManager?.stopUpdatingLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.enabled = false
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
        
    }
    
    func checkValidObject(){
        //posizione GPS valida
        // foto scattata
        saveButton.enabled = true
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 18.0)
        mapView.camera = camera
        

        
    }
    
    
    
}

