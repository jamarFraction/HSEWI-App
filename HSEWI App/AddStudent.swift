//
//  AddStudent.swift
//  HSEWI App
//
//  Created by Jamar on 3/12/18.
//  Copyright © 2018 Jamar Fraction. All rights reserved.
//

import UIKit

class AddStudent: UIViewController {
    
    override func viewDidLoad() {
        
        //Upon loading the view, set the session email via the
        currentSession.SetCreatorEmail(email: sessionEmail!)
        
    }
    
    
    //Current Session
    private var currentSession = Session(creatorEmail: "")
    
    //Email passed to this function via
    internal var sessionEmail: String?

    //[FirstName, LastName, Email, PhoneNumber]
    @IBOutlet var StudentInfo: [UITextField]!
    
    
    //Submit Button
    @IBAction func Submit() {
        
        if validateInput() ==  true {
            
            //change the text displayed in the UITextField to its formatted version
            StudentInfo[3].text = formatPhoneNumber(StudentInfo[3].text!)
            
            //TODO: Write information to Student Class
            //TODO: Insert Student into the session Student list
            //TODO: Clear All Text boxes
        }
        
    }
  
    @IBAction func PhoneNumberValidation(_ textField: UITextField) {
        
        //Guard for backspacing at string length 1 causing the app to crash
        if textField.text!.count > 0{
            
            //first check the last character that was input
            var string = textField.text!
            
            let indexOfLastChar = string.index(string.startIndex, offsetBy: textField.text!.count - 1)
            
            let lastCharacterAsInt = Int(String(string[indexOfLastChar]))
            
            //if lastCharacterAsInt is not a Integer its value will be nil
            if lastCharacterAsInt == nil || textField.text!.count > 10{
                
                if textField.text!.count > 1 {
                    
                    //Remove the character at the end of the string
                    string.remove(at: indexOfLastChar)
                    
                    //Update the text in the textbox
                    textField.text = string
                    
                }else{
                    
                    //The resulting text will be blank so don't bother messing with "string" variable
                    textField.text = ""
                }
            }
        }
    }

    
    
    //
    //User
    //Functions
    //
    //***************************************************************************************************
    
    //Validate Input
    func validateInput() -> Bool{
        
        var error = 0
        
        //reset all textboxes back to the non-highlighted color
        for textBox in StudentInfo{
            
            textBox.backgroundColor = UIColor.white
        }
        
        //check the first name
        if checkFirstName() == false{
            
            highlightTextBox(boxToHighlight: 0)
            error = 1
        }
        
        //check the last name
        if checkLastName() == false{
            
            highlightTextBox(boxToHighlight: 1)
            error = 1
        }
        
        //check the email
        if validateEmail(emailToValidate: StudentInfo[2].text!) == false{
            
            highlightTextBox(boxToHighlight: 2)
            emailAlert()
            error = 1
            
        }
        
        //check the phone number
        if StudentInfo[3].text!.count < 10 {
            
            //Phone number is "validated" in real time, see PhoneNumberValidation
            highlightTextBox(boxToHighlight: 3)
            error = 1
            
        }
        
        //check for any error
        if error == 0 {
            
            //no errors, return true
            return true
            
        }
        
        //at least 1 error
        return false
    }
    
    //Check First Name
    func checkFirstName() -> Bool{
        
        if StudentInfo[0].text!.count > 0{
            
            return true
        }
        
        return false
    }
    
    //Check Last Name
    func checkLastName() -> Bool{
        
        if StudentInfo[1].text!.count > 0 {
            
            return true
        }
        
        return false
    }
    
    //Highlight Text Box
    func highlightTextBox(boxToHighlight passedIndex: Int) {
        
        //generated using http://uicolor.xyz/#/hex-to-ui
        //from RGB values: 255, 208. 208
        StudentInfo[passedIndex].backgroundColor = UIColor(red: 1.00, green: 0.82, blue: 0.82, alpha: 1.0)

    }
    
    //Email alert function
    func emailAlert(){
        
        //Create an alert
        let emailAlert = UIAlertController(title: "Error", message: "Email must be of the format: xxx@xxx.xxx", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
        
    }
    
    //Format the phone number for data writing later
    func formatPhoneNumber(_ passedNumber: String) -> String{
        
        //TODO: Format Phone number to xxx-xxx-xxxx
        var string = passedNumber
        
        let position1 = String.Index.init(encodedOffset: 3)
        let position2 = String.Index.init(encodedOffset: 7)
        
        string.insert("-", at: position1)
        string.insert("-", at: position2)
        
        return string
    }
    //
    //End
    //User
    //Functions
    //
    //***************************************************************************************************
}


