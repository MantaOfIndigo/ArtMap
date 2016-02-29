//
//  ReportViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 26/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class ReportViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var setVisibility: UIPickerView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var setPosition: UISwitch!
    
    @IBOutlet weak var labelAccuracy: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var artInfo : Marker = Marker()
    var pickerValues: [String] = [String]()
    var locationManager: CLLocationManager?
    var visibility : String?
    var longitude : Double?
    var latitude : Double?
    var geoAccuracy : Double?
    
    @IBAction func back(sender: AnyObject) {
        
        locationManager?.stopUpdatingLocation()
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func sendReport(sender: AnyObject) {
        locationManager?.stopUpdatingLocation()
        
        if PFUser.currentUser() != nil{
            
            let intrc = Interactor()
            
            let artReport = Art(title: titleText.text, author: authorText.text, year: Int(yearText.text!))
            
            if setPosition.on{
                intrc.uploadNewReport(artInfo.getId() ,position: CLLocationCoordinate2DMake(latitude!, longitude!), art: artReport!, visibility: visibility! , geoAccuracy: geoAccuracy!, isInPosition: false)
            }else{
                intrc.uploadNewReport(artInfo.getId() ,position: CLLocationCoordinate2DMake(0, 0), art: artReport!, visibility: visibility! , geoAccuracy: 0, isInPosition: true)
            }
            AlertLauncher().launchAlertWithConfirm("Report riuscito", message: "Il report è stato inviato con successo", toView: self)
        }else{
            let alert = AlertLauncher()
            alert.launchAlert("Report fallito", message: "Devi prima effettuare il login per inviare un report", toView: self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPosition.setOn(false, animated: false)
        setVisibility.dataSource = self
        setVisibility.delegate = self
        pickerValues = ["Visibile","Rovinato o Inaccessibile","Rimosso o Distrutto"]
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        
        setPosition.addTarget(self, action: Selector("switchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        titleText.placeholder = artInfo.getArt().getTitle()
        authorText.placeholder = artInfo.getArt().getAuthor()
        yearText.placeholder = String(artInfo.getArt().getYear())
        
        
        
    }
    
    func switchChanged(setPosition: UISwitch){
        if setPosition.on{
            locationManager?.startUpdatingLocation()
        }else{
            locationManager?.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 16)
        
        latitude = loc.coordinate.latitude
        longitude = loc.coordinate.longitude
        geoAccuracy = loc.horizontalAccuracy
        
        labelAccuracy.text = "   Accuratezza posizione:  " + String(geoAccuracy!) + " metri"
        
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        visibility = pickerValues[row]
        return pickerValues[row]
    }
    
    func setReportInfo(markerInformation: Marker){
        self.artInfo = markerInformation
    }
}
