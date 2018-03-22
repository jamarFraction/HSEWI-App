//
//  Session.swift
//  HSEWI App
//
//  Created by Jamar on 3/12/18.
//  Copyright © 2018 Jamar Fraction. All rights reserved.
//

import Foundation

class Session{
    
    init(creatorEmail passedEmail: String){
        
        CreatorEmail = passedEmail
        
    }
    
    func GetCreatorEmail() -> String{
        
        return self.CreatorEmail
        
    }
    
    func SetCreatorEmail(email passedEmail: String){
        
        self.CreatorEmail = passedEmail
        
    }
    
    func AddStudent(StudentToAdd passedStudent: Student){
        
        Attendees.append(passedStudent)
        
    }
    
    func Size() -> Int{
        
        return Attendees.count
        
    }
    
    func ExportSessionInfo() -> String {
        
        //Function returns a string with all of the session information formatted such that it can be written to a .csv
        //Format:
        //LastName,FirstName,Email,PhoneNumber
        
        //Session contains no attendees, return text is empty
        if Attendees.count < 1{
            
            return ""
        }
        
        //First line of the data
        var sessionData = "Last Name,First Name, Email, Phone Number/n"
        
        //Loop through the attendees and concatenate the l
        for student in Attendees{
            
            let newLine = "\(student.FirstName),\(student.LastName),\(student.Email),\(student.PhoneNumber)\n"
            
            sessionData.append(contentsOf: newLine)
            
        }
        

        return sessionData
    }
    
    //send-to email for the session
    private var CreatorEmail: String
    
    //container of all students for the session
    private var Attendees = [Student]()
    
    
}
