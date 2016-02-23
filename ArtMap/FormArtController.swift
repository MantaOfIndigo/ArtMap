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
    @IBOutlet weak var infoDecorationLabel: UILabel!
    
    @IBAction func sendReport(sender: UIButton) {
        if let resultController = storyboard?.instantiateViewControllerWithIdentifier("reportInterface") as? ReportViewController{
            resultController.setReportInfo(setForm)
            presentViewController(resultController, animated: true, completion: nil)
        }
        
    }
    var setForm : Marker = Marker()
    
    
    @IBAction func showArtist(sender: AnyObject) {
        if setForm.getArt().getAuthor() == "" || setForm.getArt().getAuthor().uppercaseString == "UNKNOWN" {
            return
        }
        if let resultController = storyboard?.instantiateViewControllerWithIdentifier("artistProfile") as? ArtistProfileController{
            resultController.setArtist(setForm)
            presentViewController(resultController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: UIBarButtonItem) {
        
        var content : String
        if setForm.getArt().getAuthor() == ""{
            content = "Author: Unknown \n\nCondiviso con ArtMap! - versione iOS"
        }
        
        content = "Author: " + setForm.getArt().getAuthor() + " \n\nCondiviso con ArtMap! - versione iOS"
        
        let act = UIActivityViewController(activityItems: [setForm, content, setForm.getMarker()], applicationActivities: nil)
        self.presentViewController(act, animated: true, completion: nil)
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
        if tmp.getTitle() == "" || tmp.getTitle().uppercaseString == "UNKNOWN"{
            titleLabel.text = "NESSUN TITOLO"
            titleLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        authorLabel.text = tmp.getAuthor().uppercaseString
        if tmp.getAuthor() == "" || tmp.getAuthor().uppercaseString == "UNKNOWN"{
            authorLabel.text = "NESSUN AUTORE"
            authorLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
            infoDecorationLabel.hidden = true
        }
        yearLabel.text = String(tmp.getYear())
        if tmp.getYear() == 0 {
            yearLabel.text = "NESSUNA DATA"
            yearLabel.textColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
        }
        if tmp.getState() == 0{
            stateLabel.text = "NON AGGIORNATO"
        } else if tmp.getState() == 1{
            stateLabel.text = "VISIBILE"
        } else if tmp.getState() == 2{
            stateLabel.text = "ROVINATO/INACCESSIBILE"
        } else {
            stateLabel.text = "RIMOSSO"
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