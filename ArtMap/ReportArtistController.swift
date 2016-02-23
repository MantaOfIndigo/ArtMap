//
//  ReportArtistController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 20/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit

class ReportArtistController : UIViewController{
    
    
    
    @IBOutlet weak var textInformation: UITextView!
    
    private var artist : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendReport(sender: AnyObject) {
        if PFUser.currentUser()!["username"] != nil{
            Interactor().uploadNewArtistReport(textInformation.text)
            AlertLauncher().launchAlertWithConfirm("Report riuscito!", message: "Le informazioni sono state inoltrate. Verranno valutate e inserite al più presto", toView: self)
        }else{
            AlertLauncher().launchAlertWithConfirm("Report Fallito", message: "Si è presentato un errore con le tue credenziali, effettua il login", toView: self)
        }
    }
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setArtist(artist : String){
        self.artist = artist
    }
}
