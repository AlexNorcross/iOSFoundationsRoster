//
//  Person.swift
//  iOS Foundations Roster
//
//  Created by Alexandra Norcross on 11/3/14.
//  Copyright (c) 2014 Alexandra Norcross. All rights reserved.
//

import UIKit

//Class: Person containing name and image.

class Person {
    var nameFirst: String = "First"
    var nameLast: String = "Last"
    var imagePerson: UIImage?
    
    //Initialization: blank
    init() {
    }
    
    //Initialization: name
    init(nameFirst: String, nameLast: String) {
        self.nameFirst = nameFirst
        self.nameLast = nameLast
    }
    
    //Function: Returns person's first and last name combined.
    func getFullName() -> String {
        return self.nameFirst + " " + self.nameLast
    }
}