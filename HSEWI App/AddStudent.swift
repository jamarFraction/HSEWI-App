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
    
    //Email confirmation var
    //False = Exporting not enabled
    private var emailConfirmed = false
    
    //Email passed to this function via
    internal var sessionEmail: String?

    //[FirstName, LastName, Email, PhoneNumber]
    @IBOutlet var StudentInfo: [UITextField]!
    
    
    //Submit Button
    @IBAction func Submit() {
        
        if validateInput() ==  true {
            
            //change the text displayed in the UITextField to its formatted version
            StudentInfo[3].text = formatPhoneNumber(StudentInfo[3].text!)
            
            //Create a new Student with the information gathered from the text boxes
            //and insert it to the session list
            currentSession.AddStudent(StudentToAdd: Student(FirstName: StudentInfo[0].text!, LastName: StudentInfo[1].text!, PhoneNumber: StudentInfo[2].text!, Email: StudentInfo[3].text!))
            
            //Display the submission confirmation alert
            submissionConfirmationAlert()
            
            //Clear All Text boxes
            self.clearTextBoxes()
            
            //set the focus back to the first text box
            StudentInfo[0].becomeFirstResponder()
            
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

    @IBAction func EndSession() {
        
        //Pompt the user for the session creation email
        EndSessionValidation()
        
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
            emailFormatAlert()
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
    
    func EndSessionValidation(){
        
        //Will hold the data input to the alert textbox
        var textField: String = ""
        
        //Alert Controller
        let endSessionAlert = UIAlertController(title: "End Current Session", message: "Please enter the email used when creating this session", preferredStyle: .alert)
        
        //Submit option
        let submit = UIAlertAction(title: "Submit", style: .default, handler: {(_) in
            
            //set the textfield variable with the value from the textbox
            textField = endSessionAlert.textFields![0].text!
            
            //check to see if the text entered matches the email used to create the session
            if textField.lowercased() == self.currentSession.GetCreatorEmail().lowercased(){
                
                //text matches so confirm the email
                self.emailConfirmed = true
                
            }
            
            //TODO: Complete pending device testing - Handle the exporting of session data
            if self.emailConfirmed == true {
                
                //Check for empty Session list
                if self.currentSession.Size() > 0 {
                    
                    //Create the file and export
                    self.CreateFileAndExport()
                    
                    //Perform a Segue back to the Home screen of the app
                    self.performSegue(withIdentifier: "ReturnToBeginning", sender: nil)
                    
                }else{
                    
                    //The list is empty
                    self.emptySessionAlert()
                    
                }
            }else{
                
                //Present the incorrect email alert
                self.incorrectSessionEmailAlert()
                
            }
        })
        
        //cancel option
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in })
        
        //Add the textbox to the alert
        endSessionAlert.addTextField(configurationHandler: {(textBox: UITextField) in
            
            textBox.keyboardAppearance = .dark
        })
        
        //Add the Submit option to the alert
        endSessionAlert.addAction(submit)
        
        //Add the cancel option to the alert
        endSessionAlert.addAction(cancel)
        
        //Present the alert
        self.present(endSessionAlert, animated: true)
    }
    
    
    //Incorrect Email format alert
    func emailFormatAlert(){
        
        //Create an alert
        let emailAlert = UIAlertController(title: "Error", message: "Email must be of the format: xxx@xxx.xxx", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
        
    }
    
    
    //Incorrect session email alert
    func incorrectSessionEmailAlert(){
        
        //Create an alert
        let emailAlert = UIAlertController(title: "Error", message: "The email you entered does not match the one entered to create this session", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
    }
    
    func emptySessionAlert(){
        
        //Create an alert
        let emailAlert = UIAlertController(title: "Warning", message: "The current session has no attendees, are you sure you would like to exit?", preferredStyle: .alert)
        
        //Confirmation option
        emailAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            //User is ok with returning to the home screen
            self.performSegue(withIdentifier: "ReturnToBeginning", sender: nil)
            
            }))
        
        //Cnacel option
        emailAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Present the alert
        self.present(emailAlert, animated: true)
        
    }
    
    
    //Submission Confirmation Alert function
    func submissionConfirmationAlert(){
        
        //Create an alert
        let submissionAlert = UIAlertController(title: "Confirmation", message: "Thank You. Your information has been recorded!", preferredStyle: .alert)
        submissionAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Present the alert
        self.present(submissionAlert, animated: true)
    }
   

    //Format the phone number for data writing later
    func formatPhoneNumber(_ passedNumber: String) -> String{
        
        var string = passedNumber
        
        //location to add the dashes
        let position1 = String.Index.init(encodedOffset: 3)
        let position2 = String.Index.init(encodedOffset: 7)
        
        //insertion
        string.insert("-", at: position1)
        string.insert("-", at: position2)
        
        return string
    }
    
    func clearTextBoxes(){
        
        for textBox in StudentInfo{
            
            textBox.text = ""
            
        }
        
    }
    
    func CreateFileAndExport(){
        
        //let fileName = "Tasks.csv"
        //let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(fileName)
        let fileName = Date().description
        
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        let csvText = currentSession.ExportSessionInfo()
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            
            let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
            
            vc.excludedActivityTypes = [
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToWeibo,
                UIActivityType.postToTwitter,
                UIActivityType.postToFacebook,
                UIActivityType.openInIBooks]
            
            present(vc, animated: true, completion: nil)
            
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    //
    //End
    //User
    //Functions
    //
    //***************************************************************************************************
}


