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
    let launcher = AlertLauncher()
    
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
            //carica
            let intrct = Interactor()
            intrct.uploadNewUser(User(username: username.text!, email: email.text!), password: password.text!)
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    

    
    func checkParameters()-> Bool{
        if password.text != confirmPassword.text{
            launcher.launchAlert( "Password non confermata", message: "Password ripetuta non correttamente", toView: self)
            return false
        }
        if password.text?.characters.count < 5 || password.text?.characters.count > 12{
            launcher.launchAlert("Formato password non corretto", message: "La password deve avere un minimo di 5 e un massimo di 12 caratteri", toView: self)
            return false
        }
        if launcher.isValidEmail(email.text!) == false {
            launcher.launchAlert("Email non valida", message: "Controlla che l'indirizzo sia esatto", toView: self)
            return false
        }
        if ((userController?.checkEmail(email.text!)) == false){
            launcher.launchAlert("Email non valida", message: "Questo indirizzo email è già stato utilizzato", toView: self)
            return false
        }
        if ((userController?.checkUsername(username.text!)) == false){
            launcher.launchAlert("Username non valido", message: "Questo username è già stato utilizzato", toView: self)
            return false
        }
        
        return true
    }
    
    
    
    @IBAction func loginAction(sender: UIButton) {
        let intrct = Interactor()
        do{
            if try intrct.retrieveLogin(email.text!, password: password.text!)  == true{
                
                dismissViewControllerAnimated(true, completion: nil)
            }
        }catch{
            print("trmo")
        }

    }
   
    
   
}
