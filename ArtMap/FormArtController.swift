//
//  FormArtController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 10/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class FormArtController : UIViewController{
    
    
    @IBOutlet weak var imageForm: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    var setForm : Marker = Marker()
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
        titleLabel.text = tmp.title.capitalizedString
        authorLabel.text = tmp.author.capitalizedString
        yearLabel.text = String(tmp.year)
        if tmp.visibility != 0{
            stateLabel.text = "NON VISIBILE"
        }
        super.viewDidLoad()

    }
    func setForm(value: Marker){
        self.setForm = value
        
    }
    
    
}