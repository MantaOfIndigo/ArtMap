//
//  alertLauncher.swift
//  ArtMap
//
//  Created by Andrea Mantani on 28/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit

class AlertLauncher: UIViewController{
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    func launchAlert(title: String, message: String, toView: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Indietro", style: UIAlertActionStyle.Default, handler: nil))
        toView.presentViewController(alertController, animated: true, completion: nil)
    }
}
