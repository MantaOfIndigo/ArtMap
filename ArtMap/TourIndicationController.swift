//
//  TourIndicationController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 17/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class TourIndicationController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, IndicatorView{
   
    private var tourMarkerSteps : [Marker]?
    private var locationManager : CLLocationManager?
    private var dirMan : DirectionManager?
    private var stepCollection : [Step]?
    private var stepIndex : Int?
    private var reOpen : Bool?
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var mapDirectionView: MKMapView!
    
    @IBAction func prevStep(sender: AnyObject) {
        stepIndex = stepIndex! - 1
        if (stepIndex >= 0){
            lblDistance.text = "Distance: " + String(stepCollection![stepIndex!].getDistance()) + " meters"
            lblInstructions.text = stepCollection![stepIndex!].getInstructions()
        }
    }
    @IBAction func nextStep(sender: AnyObject) {
        stepIndex = stepIndex! + 1
        if (stepIndex >= (stepCollection?.count)!){
            AlertLauncher().launchAlert("Tour completo", message: "Sei arrivato a destinazione!", toView: self)
        }else{
            lblDistance.text = "Distance: " + String(stepCollection![stepIndex!].getDistance()) + " meters"
            lblInstructions.text = stepCollection![stepIndex!].getInstructions()
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setTourSteps(tourSteps: [Marker], reOpeningTour : Bool){
        self.reOpen = reOpeningTour
        self.tourMarkerSteps = tourSteps
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            print("done")
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapDirectionView.delegate = self
        mapDirectionView.showsUserLocation = true
        
        stepCollection = [Step]()
        stepIndex = 0
        
        lblDistance.text = ""
        lblInstructions.text = ""
        
        var annotation : MKPointAnnotation
        for marker in tourMarkerSteps!{
            annotation = MKPointAnnotation()
            annotation.coordinate = marker.getMarker().position
            mapDirectionView.addAnnotation(annotation)
        }
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
        
    }
    
    func addOverlay(polyline : MKPolyline, boundingRegion: MKMapRect, steps : [Step]){
        print(steps.count)
        if(steps.count == 0){
            AlertLauncher().launchAlertWithConfirm("Errore", message: "Sei troppo distante", toView: self)
        }else{
        
            mapDirectionView.addOverlay(polyline)
            mapDirectionView.setVisibleMapRect(boundingRegion, animated: true)
        
            self.stepCollection?.appendContentsOf(steps)
        
            lblDistance.text = "Distance: " + String(stepCollection![stepIndex!].getDistance()) + " meters"
            lblInstructions.text = stepCollection![stepIndex!].getInstructions()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        tourMarkerSteps?.insert(Marker(position: loc.coordinate, id: 0), atIndex: 0)
        if(dirMan == nil){
            dirMan = DirectionManager(direction: tourMarkerSteps!, toView: self)
            if (reOpen == false){
                dirMan?.saveTour()
            }
        }
        
        locationManager!.stopUpdatingLocation()
    }
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "direction")
        10206275912729473
        let idx:Int = indexPath.row
        
        let dictTable:NSDictionary = tableData[idx] as! NSDictionary
        let instruction = dictTable["instructions"] as! String
        let distance = dictTable["distance"] as! NSString
        let duration = dictTable["duration"] as! NSString
        let detail = "distance:\(distance) duration:\(duration)"
        
        
        cell.textLabel!.text = instruction
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.font = UIFont(name: "Helvetica Neue Light", size: 15.0)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //cell.textLabel.font=  [UIFont fontWithName:"Helvetica Neue-Light" size:15];
        cell.detailTextLabel!.text = detail
        
        return cell
    }
    */
    
    
}


