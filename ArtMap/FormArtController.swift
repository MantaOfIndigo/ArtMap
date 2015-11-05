//
//  FormArtController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 10/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import Social

class FormArtController : UIViewController{
    
    
    @IBOutlet weak var imageForm: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBAction func sendReport(sender: UIButton) {
        if let resultController = storyboard?.instantiateViewControllerWithIdentifier("reportInterface") as? ReportViewController{
            resultController.setReportInfo(setForm)
            presentViewController(resultController, animated: true, completion: nil)
        }

    }
    var setForm : Marker = Marker()
    
    
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: UIBarButtonItem) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let fbshare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            self.presentViewController(fbshare, animated: true, completion: nil)
        }else{
            let alert = AlertLauncher()
            alert.launchAlert("Accounts", message: "Occorre eseguire il login con Facebook prima di condividere", toView: self)
        }
        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        imageForm.image = setForm.getImage()
        
        let tmp = setForm.getArt()
        
        titleLabel.text = tmp.getTitle().capitalizedString
        if tmp.getTitle() == "" {
            titleLabel.text = "NESSUN TITOLO"
            titleLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        authorLabel.text = tmp.getAuthor().capitalizedString
        if tmp.getAuthor() == ""{
            authorLabel.text = "NESSUN AUTORE"
            authorLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        yearLabel.text = String(tmp.getYear())
        if tmp.getYear() == 0 {
            yearLabel.text = "NESSUNA DATA"
            yearLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        if tmp.getState() != 0{
            stateLabel.text = "NON AGGIORNATO"
            stateLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        super.viewDidLoad()

    }
    func setFormInfo(value: Marker){
        self.setForm = value
        
        print(value.getArt().getTitle())
        
        print(self.setForm.getArt().getTitle())
        
    }
    
    
}