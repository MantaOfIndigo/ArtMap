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
    
    @IBOutlet weak var cameraPhoto: UIImageView!
    private var imageToSend : UIImage?
    //private var newMedia: Bool?
    private var imagePickerController : UIImagePickerController!
    private var locationManager : CLLocationManager?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private var position = CLLocationCoordinate2D()
    private var geoAccuracy = Double()
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func useCamera(sender: AnyObject) {
      
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .Camera
        imagePickerController.cameraCaptureMode = .Photo
        imagePickerController.mediaTypes = [kUTTypeImage as String]
    
        presentViewController(imagePickerController, animated: true, completion: nil)
            }}
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
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        cameraPhoto.image = image
        imageToSend = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        locationManager?.stopUpdatingLocation()
        
        if segue.identifier == "segueAddArt"{
            if let resultController = segue.destinationViewController as? AddArtInfoView{
                //resultController.imageToSend = immagine dalla fotocamera
                resultController.setInformation(imageToSend!, coordinate: self.position, geoAccuracy : geoAccuracy)
                presentViewController(resultController, animated: true, completion: nil)
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
        mapView.myLocationEnabled = true
        
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

