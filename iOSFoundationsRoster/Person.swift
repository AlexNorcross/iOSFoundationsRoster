//
//  Person.swift
//  iOS Foundations Roster
//
//  Created by Alexandra Norcross on 11/3/14.
//  Copyright (c) 2014 Alexandra Norcross. All rights reserved.
//

import UIKit

//Class: Person containing name, student status, and image.

class Person : NSObject, NSCoding {
    var nameFirst: String = "First"
    var nameLast: String = "Last"
    var isStudent: Bool = false
    var imagePerson: UIImage?
    
    //Initialization: blank
    override init() {
    } //end init
    
    //Initialization: first and last names; student status
    init(nameFirst: String, nameLast: String, isStudent: Bool) {
        self.nameFirst = nameFirst
        self.nameLast = nameLast
        self.isStudent = isStudent
    } //end init
    
    //Function: Loads Person from archive.
    required init(coder aDecoder: NSCoder) {
        self.nameFirst = aDecoder.decodeObjectForKey("nameFirst") as String
        self.nameLast = aDecoder.decodeObjectForKey("nameLast") as String
        if let imageDecoded = aDecoder.decodeObjectForKey("imagePerson") as? UIImage {
            self.imagePerson = imageDecoded
        } //end if
    } //end init
    
    //Function: Saves Person to archive.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.nameFirst, forKey: "nameFirst")
        aCoder.encodeObject(self.nameLast, forKey: "nameLast")
        aCoder.encodeObject(self.imagePerson, forKey: "imagePerson")
    } //end func
    
    //Function: Returns person's first and last name combined.
    func getFullName() -> String {
        return self.nameFirst + " " + self.nameLast
    } //end func
}