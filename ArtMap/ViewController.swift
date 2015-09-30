//
//  ViewController.swift
//  ArtMap!
//
//  Created by Andrea Mantani on 25/09/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var locator: Locator?
    
    @IBOutlet weak var photoImg: UIImageView!
    
    
    @IBOutlet weak var viewMap: GMSMapView!
    var placesClient: GMSPlacesClient?
    
    @IBAction func tapPhoto(sender: UITapGestureRecognizer) {
        //Apri nuova finestra
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locator = Locator()
        locator!.fetchWithCompletion{location, error in
            if let loc = location {
            print(location)
            } else if let err = error{
                print(err.localizedDescription)
            }
            self.locator = nil
        }
    }
    
    
    /*
    @IBAction func getCurrentPlace(sender: UIButton) {
        placesClient?.currentPlaceWithCallback({ (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error{
                print("Pick place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place{
                    self.nameLabel.text = place.name
                    self.addressLabel.text = "\n" + place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator(", ")
                }
            }
        })
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(48.857165, longitude: 2.354613, zoom: 8.0)
        viewMap.camera = camera
        // Do any additional setup after loading the view, typically from a nib.
    }
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
