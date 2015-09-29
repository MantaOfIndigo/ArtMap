//
//  AddArtController.swift
//  ArtMap!
//
//  Created by Andrea Mantani on 27/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import MobileCoreServices

class AddArtController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newMedia: Bool?
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var addMap: GMSMapView!
    var placesClient: GMSPlacesClient?
    
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.enabled = false
        
        // SET LOCATION ----------------------------------------------------
        placesClient = GMSPlacesClient()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(48.857165, longitude: 2.354613, zoom: 8.0)
        addMap.camera = camera
        // Do any additional setup after loading the view, typically from a nib.
        // SET LOCATION ----------------------------------------------------
    }
    
    func checkValidObject(){
        //posizione GPS valida
        // foto scattata
        saveButton.enabled = true
    }
    
    
    
}
