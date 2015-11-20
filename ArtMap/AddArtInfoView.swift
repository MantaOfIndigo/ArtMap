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
    @IBOutlet weak var sendHD: UISwitch!
   
    var imageToSend = UIImage()
    var author = String()
    var geoAccuracy = Int()
    var imageId = String()
    var position = CLLocationCoordinate2DMake(0, 0)
    var titleArt = String()
    var year = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        authorText.delegate = self
        yearText.delegate = self
    }
    
  
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBAction func send(sender: UIButton) {
        if prepareFields(){
            Interactor().uploadArt(PFUser.currentUser()!["username"] as! String, location: position, image: imageToSend, accuracy: geoAccuracy, art: Art(title: titleArt, author: author, year: Int(year)!, status: 0)!)
        }
    }
    
    @IBAction func exit(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func locationToUpload(position: CLLocationCoordinate2D, accuracy: Int, image: UIImage){
    
    }
    //  author geoAccuracy imageFile imageId latitude longitude title user year
    func prepareFields() -> Bool{
        author = authorText.text!
        titleArt = titleText.text!
        if let _ = Int(yearText.text!){
            AlertLauncher().launchAlert("Errore", message: "L'anno inserito non è un numero", toView: self)
            yearText.text = ""
            
            return false
        }
        
        return true
    }
    
}
