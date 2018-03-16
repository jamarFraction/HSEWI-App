//
//  Student.swift
//  HSEWI App
//
//  Created by Jamar on 3/12/18.
//  Copyright © 2018 Jamar Fraction. All rights reserved.
//

import Foundation

class Student{
    
    
    init(FirstName passedFirstName: String, LastName passedLastName: String, PhoneNumber passedPhoneNumber: String, Email passedEmail: String){
        
        self.FirstName = passedFirstName
        self.LastName = passedLastName
        self.PhoneNumber = passedPhoneNumber
        self.Email = passedEmail
    
    }
    
    var FirstName: String
    var LastName: String
    var PhoneNumber: String
    var Email: String
    
}
