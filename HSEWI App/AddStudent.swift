//
//  AddStudent.swift
//  HSEWI App
//
//  Created by Jamar on 3/12/18.
//  Copyright © 2018 Jamar Fraction. All rights reserved.
//

import UIKit

class AddStudent: UIViewController {

    
    
    //[FirstName, LastName, Email, PhoneNumber]
    @IBOutlet var StudentInfo: [UITextField]!
    
    
    //Submit Button
    @IBAction func Submit() {
        
        if validateInput() ==  true {
            
            print("TRUE")
        }
        
    }
  
    @IBAction func FormatPhoneNumber(_ textField: UITextField) {
        
        //Guard for backspacing at string length 1 causing the app to crash
        if textField.text!.count > 0{
            
            //first check the last character that was input
            var string = textField.text!
            
            let indexOfLastChar = string.index(string.startIndex, offsetBy: textField.text!.count - 1)
            
            let lastCharacterAsInt = Int(String(string[indexOfLastChar]))
            
            //if lastCharacterAsInt is not a Integer its value will be nil
            if lastCharacterAsInt == nil{
                
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
        
        //reset all textboxes back to the non-highlighted color
        for textBox in StudentInfo{
            
            textBox.backgroundColor = UIColor.white
        }
        
        //check the first name
        if checkFirstName() == false{
            
            highlightTextBox(boxToHighlight: 0)
        }
        
        //check the last name
        if checkLastName() == false{
            
            highlightTextBox(boxToHighlight: 1)
        }
        
        //check the email
        if validateEmail(emailToValidate: StudentInfo[3].text!) == false{
            
            highlightTextBox(boxToHighlight: 2)
            emailAlert()
            
        }
        
        

        
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
        
        StudentInfo[passedIndex].backgroundColor = UIColor.red
        StudentInfo[passedIndex].isOpaque = true
        StudentInfo[passedIndex].alpha = CGFloat(0.1)
        
    }
    
    //Email alert function
    func emailAlert(){
        
        //Create an alert
        let emailAlert = UIAlertController(title: "Error", message: "Email must be of the format: xxx@xxx.xxx", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
        
    }
    
    func formatPhoneNumber(_ passedNumber: String) -> String{
        
        
        
        return ""
    }
    //***************************************************************************************************
}

