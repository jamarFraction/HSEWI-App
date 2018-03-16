//
//  ViewController.swift
//  HSEWI App
//
//  Created by Jamar on 3/12/18.
//  Copyright © 2018 Jamar Fraction. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Text field outlet
    @IBOutlet weak var emailField: UITextField!
    
    //Session
    lazy var currentSession = Session(creatorEmail: "")
    
    
    @IBAction func StartSession() {
        
        //make sure the feild has text
        if(emailField.text != nil){
            
            //validate the email format
            if(validateEmail(emailToValidate: emailField.text!) == true){
                
                //passed validation, create session
                currentSession = Session(creatorEmail: emailField.text!)
            
                //Segue to AddStudent View
                performSegue(withIdentifier: "AddStudent", sender: nil)
            }
            //failed validation, present email error
            emailAlert()
        }
    }
    
    
    
    
    
    
    
    
    //***************************************************************************************************
    //Email alert function
    func emailAlert(){
    
        //Create an alert
        let emailAlert = UIAlertController(title: "Error", message: "Email must be of the format: xxx@xxx.xxx", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
        
    }
    //***************************************************************************************************
}

//email validation
public func validateEmail(emailToValidate passedEmail: String) -> Bool{
    
    //email must contain an "@"
    if(passedEmail.contains("@")){
        
        //get the index of "@" and create a substring starting at that index..end
        let index = passedEmail.index(of: "@") ?? passedEmail.endIndex
        let end = passedEmail[index..<passedEmail.endIndex]
        
        //email domain will now contain "@xxx.xxx"
        let emailDomain = String(end)
        
        //check for the "." in the domain
        if(emailDomain.contains(".")){
            
            //email will suffice
            return true
        }
    }
    
    return false
}

