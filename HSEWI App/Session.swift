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
    
    //send-to email for the session
    private var CreatorEmail: String
    
    //container of all students for the session
    private var Attendees = [Student]()
    
    
}