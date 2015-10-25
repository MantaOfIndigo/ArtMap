//
//  LoginViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 14/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Parse

class LoginViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var username: UITextField!
    
    var userController : UserController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        
    }
    
    func setUserList(value : UserController){
        self.userController = value
    }
    
    @IBAction func cancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func showPrivacy(sender: UIButton) {
        print("lancia view per privacy con testo")
    }
    @IBAction func signIn(sender: UIButton) {
        
        if checkParameters(){
        let lista = PFObject(className: "ClassListaUtenti")
        
        lista["username"] = username.text
        lista["email"] = email.text
        lista["password"] = password.text
        
        lista.saveInBackgroundWithBlock{ (Bool, NSError) -> Void in
            if NSError == nil{
                print("salvato")
            }
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    func checkParameters()-> Bool{
        if password.text != confirmPassword.text{
            launchAlert( "Password non confermata", message: "Password ripetuta non correttamente")
            return false
        }
        if password.text?.characters.count < 5 || password.text?.characters.count > 12{
            launchAlert("Formato password non corretto", message: "La password deve avere un minimo di 5 e un massimo di 12 caratteri")
            return false
        }
        if isValidEmail(email.text!) == false {
            launchAlert("Email non valida", message: "Controlla che l'indirizzo sia esatto")
            return false
        }
        if ((userController?.checkEmail(email.text!)) == false){
            launchAlert("Email non valida", message: "Questo indirizzo email è già stato utilizzato")
            return false
        }
        if ((userController?.checkUsername(username.text!)) == false){
            launchAlert("Username non valido", message: "Questo username è già stato utilizzato")
            return false
        }
        
        return true
    }
    
    func launchAlert(title: String, message: String){
        password.text = ""
        confirmPassword.text = ""
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Indietro", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: UIButton) {
         print("login")
    }
}
