//
//  AddTourController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 15/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class AddTourController : UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{
    
    private var locationManager: CLLocationManager!
    private var markerController : MarkerController!
    private var markerForTour : [Marker] = [Marker]()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueNewTour"{
            if let result = segue.destinationViewController as? TourIndicationController{
                result.setTourSteps(markerForTour, reOpeningTour: false)
                presentViewController(result, animated: true, completion: nil)
            }
        }
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
        mapView.delegate = self
        mapView.myLocationEnabled = true
        //mapView.settings.myLocationButton = true
        //mapView.myLocationEnabled = true
        
        descriptionLabel.text = ""
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        setMarkers()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0] as CLLocation
        
        let placesClient = GMSPlacesClient()
        let camera : GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 18)
        locationManager.stopUpdatingLocation()
        mapView.camera = camera
   /*
        
        var latitute:CLLocationDegrees =  loc.coordinate.latitude
        var longitute:CLLocationDegrees =  loc.coordinate.longitude
        
        var coordinate = CLLocationCoordinate2DMake(latitute, longitute)
        
        var placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)
        
        var mapItem:MKMapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "Target location"
        
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey)
        
        var currentLocationMapItem:MKMapItem = MKMapItem.mapItemForCurrentLocation()
        
        MKMapItem.openMapsWithItems([currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : AnyObject])*/

    }
   

    private func popUpView(marker: GMSMarker, image: UIImage){
        var popview = ArtInfoView(nibName: "ArtInfoView", bundle: nil)
        if let tmp = markerController?.getMarker(marker)! {
            popview.setInformation(Interactor().retriveDBMarkerInfo(tmp))
        }
        popview.showInView(self.view, animated: true, image: image)
    }
    
    private func getArtInformation (marker: Marker) -> Art{
        let intrct = Interactor()
        return intrct.retriveDBMarkerInfo(marker).getArt()
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        
        let markInfo = markerController?.getMarker(marker)
        descriptionLabel.text = ""
        if(UIImage(named: "marker")?.isEqual(marker.icon)) == true{
            marker.icon = UIImage(named:"selected")
            let artInfo = getArtInformation(markInfo!)
            if(artInfo.getAuthor() == "" && artInfo.getAuthor() == "UNKNOWN"){
                descriptionLabel.text = "Autore: Sconosciuto"
            }else{
                descriptionLabel.text = "Autore: " + artInfo.getAuthor()
            }
            
            // let tmpimage = markInfo.getImage()
            //popUpView(marker, image: tmpimage)
            
            markerForTour.append(markInfo!)
            
            let image = getImage(markInfo!)
            var infoWindow : CustomInfoWindow = CustomInfoWindow()
            infoWindow.prepareImage(image)
            infoWindow = NSBundle.mainBundle().loadNibNamed("InfoWindow", owner: self, options: nil).first! as! CustomInfoWindow
            
            infoWindow.image.image = image
            
            return infoWindow
            
        }else{
            if markerForTour.count > 0{
                marker.icon = UIImage(named: "marker")
                markerForTour.removeAtIndex(markerForTour.indexOf(markerController.getMarker(marker!)!)!)
            }
        }
        
       return nil
    }
    private func getImage(marker : Marker) -> UIImage{
        return Interactor().retriveDBMarkerImage(marker)
    }
   
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
                        self.markerController.createList(object).getMarker().map = self.mapView
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error")
            }
        }
        
    }
    
}
