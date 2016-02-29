//
//  AddArtInfoView.swift
//  ArtMap
//
//  Created by Andrea Mantani on 15/11/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class AddArtInfoView: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var visible: UISwitch!
    // la visibilità non viene impostata dall'utente
    private var imageToSend : UIImage?
    private var markerToUpload : Marker?
    private var author = String()
    private var geoAccuracy = Double()
    //private var imageId = String()
    private var position = CLLocationCoordinate2DMake(0, 0)
    private var titleArt = String()
    private var year = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        authorText.delegate = self
        yearText.delegate = self
        
        titleText.text = ""
        authorText.text = ""
        yearText.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBAction func send(sender: UIButton) {
        if prepareFields(){
            if PFUser.currentUser() != nil{
             print(PFUser.currentUser()!["username"])
                print(imageToSend)
            Interactor().uploadArt(PFUser.currentUser()!["username"] as! String, location: position, image: imageToSend, accuracy: 0, art: Art(title: titleArt, author: author, yearString: year, status: 0))
                
                AlertLauncher().launchAlertWithConfirm("Upload riuscito!", message: "La tua immagine è stata caricata con successo. Il nostro staff procederà ad aggiungerla al più presto", toView: self)
            }else{
                AlertLauncher().launchAlert("Errore", message: "Non hai effettuato il login", toView: self)
            }
        }
    }
    
    
    func setInformation(image: UIImage, coordinate: CLLocationCoordinate2D, geoAccuracy : Double){
        self.imageToSend = image
        self.geoAccuracy = geoAccuracy
        if PFUser.currentUser() != nil{
             markerToUpload = Marker(position: coordinate, id: 0)
        }else{
            AlertLauncher().launchAlert("Errore", message: "Non hai effettuato il login", toView: self)
        }
    }
    
    @IBAction func exit(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func locationToUpload(position: CLLocationCoordinate2D, accuracy: Int, image: UIImage){
        
    }
    //  author geoAccuracy imageFile imageId latitude longitude title user year
    private func prepareFields() -> Bool{
        author = authorText.text!
        titleArt = titleText.text!
        if let _ = Int(yearText.text!){
            
        }else{
            AlertLauncher().launchAlert("Errore", message: "L'anno inserito non è un numero", toView: self)
            yearText.text = ""
            
            return false
        }
        
        geoAccuracy = round(geoAccuracy)
        
        
        
        return true
    }
    
}
