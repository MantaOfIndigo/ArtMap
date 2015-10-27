//
//  ReportViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 26/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import Parse

class ReportViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var setVisibility: UIPickerView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var setPosition: UISwitch!
    
    @IBOutlet weak var labelAccuracy: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var pickerValues: [String] = [String]()
    var locationManager: CLLocationManager?
    
    @IBAction func back(sender: UIButton) {
        locationManager?.stopUpdatingLocation()
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func sendReport(sender: UIButton) {
        locationManager?.stopUpdatingLocation()
        
        if setPosition.on{
            //prendi la locazione
        }else{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPosition.setOn(true, animated: false)
        setVisibility.dataSource = self
        setVisibility.delegate = self
        pickerValues = ["Visibile","Rovinato o Inaccessibile","Rimosso o Distrutto"]
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
        
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 16)
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
}
