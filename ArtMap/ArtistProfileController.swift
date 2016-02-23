//
//  ArtistProfileController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 15/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit

class ArtistProfileController : UIViewController{
    
    @IBOutlet weak var backgroundArtistImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorDescription: UITextView!
    @IBOutlet weak var occurenciesLabel: UILabel!
    
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private var currentArtist : String = String()
    private var currentImageToDisplay : UIImage = UIImage()
    
    @IBAction func showReportView(sender: AnyObject) {
        if let resultController = storyboard?.instantiateViewControllerWithIdentifier("reportArtistView") as? ReportArtistController{
            
            if PFUser.currentUser() != nil{
                resultController.setArtist(currentArtist)
                presentViewController(resultController, animated: true, completion: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundArtistImage.image = currentImageToDisplay
        authorLabel.text = currentArtist.uppercaseString
        let occurencies = String(Interactor().retrieveArtistMappingOccurencies(currentArtist))
        let information = Interactor().retrieveArtistInformation(currentArtist)
        
        if information != "NOSUCHITEMS"{
            authorDescription.text = information
        }
        
        if occurencies == "1"{
            occurenciesLabel.text = occurencies + " opera mappata"
            
        }else{
            occurenciesLabel.text = occurencies + " opere mappate"
            
        }
        
    }
    
  
    
    func setArtist(artistInformation : Marker){
        currentArtist = artistInformation.getArt().getAuthor()
        currentImageToDisplay = artistInformation.getImage()
    }
    
}
