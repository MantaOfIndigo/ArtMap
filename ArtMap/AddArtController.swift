//
//  AddArtController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 29/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//


import UIKit
//import GoogleMaps
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
    
    var position = CLLocationCoordinate2D()
    var geoAccuracy = Double()
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        /*
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }*/
        
    // if la foto è valida{
            saveButton.enabled = true
    //  }
    }
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        addCameraImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        locationManager?.stopUpdatingLocation()

        if sender === saveButton{
            if let resultController = storyboard?.instantiateViewControllerWithIdentifier("addInformation") as? AddArtInfoView{
                resultController.geoAccuracy = self.geoAccuracy
                resultController.position = self.position
                //resultController.imageToSend = immagine dalla fotocamera
            }

            //Crea nuovo oggetto Art e invialo
            
            /*let new = Marker(position: <#T##CLLocationCoordinate2D#>, title: <#T##String#>, author: <#T##String#>, year: <#T##Int#>, visibility: <#T##Int#>)*/
            
        }
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        position.longitude = loc.coordinate.longitude
        position.latitude = loc.coordinate.latitude
        geoAccuracy = loc.horizontalAccuracy
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 18.0)
        mapView.camera = camera
        
    }
    
  
    
}

