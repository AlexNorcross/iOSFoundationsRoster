//
//  DetailViewController.swift
//  iOS Foundations Roster
//
//  Created by Alexandra Norcross on 11/5/14.
//  Copyright (c) 2014 Alexandra Norcross. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Text Fields: Person's first & last names
    @IBOutlet weak var textNameFirst: UITextField!
    @IBOutlet weak var textNameLast: UITextField!
    
    //Image: Person's photo
    @IBOutlet weak var imagePerson: UIImageView!

    //Image picker controller: source [camera] of Person's image
    var imagePickerController = UIImagePickerController()
    
    //Selected Person:
    var selectedPerson = Person()
    
    //Function: Set view for selected Person.
    override func viewDidLoad() {
        //Super:
        super.viewDidLoad()
        
        //Title: set to selected Person's name.
        self.title = self.selectedPerson.getFullName()
        
        //Set text field delegates.
        self.textNameFirst.delegate = self
        self.textNameLast.delegate = self
        
        //Set image picker controller delegate.
        self.imagePickerController.delegate = self
        
        //Display names of selected Person in text fields.
        self.textNameFirst.text = self.selectedPerson.nameFirst
        self.textNameLast.text = self.selectedPerson.nameLast
        //Display image of selected Person, if any, in image view; if none, set to question mark image.
        if self.selectedPerson.imagePerson != nil {
            self.imagePerson.image = self.selectedPerson.imagePerson
        } else {
            self.imagePerson.image = UIImage(named: "QuestionMark.png")
        } //end if
    } //end func
    
    //Function: Dismiss keyboard when user presses Return.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Dismiss keyboard.
        textField.resignFirstResponder()
        //Return function value [non-functional here].
        return true
    } //end func
    
    //Function: Camera button pressed. Show camera to allow user to take a photo of Person.
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            //Set image picker controller source.
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            //Allow editing of image.
            self.imagePickerController.allowsEditing = true
            //Present camera to user.
            presentViewController(self.imagePickerController, animated: true, completion: nil)
        } //end if
    } //end func
    
    //Function: After user has selected image, set camera's image to image on view controller. Dismiss camera.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //Retrieve camera [image picker controller] image.
        let imageSelected = info[UIImagePickerControllerEditedImage] as UIImage
        //Set view controller's image to camera's image.
        self.imagePerson.image = imageSelected
        //Dismiss camera.
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    } //end func
    
    //Function: Update selected Person's properties, if changed.
    override func viewWillDisappear(animated: Bool) {
        //Super:
        super.viewWillDisappear(animated)
        
        //Update selected Person's properties, if changed.
        if self.selectedPerson.nameFirst != self.textNameFirst.text {
            self.selectedPerson.nameFirst = self.textNameFirst.text
        } //end if
        if self.selectedPerson.nameLast != self.textNameLast.text {
            self.selectedPerson.nameLast = self.textNameLast.text
        } //end if
        var isImageQuestionMark = (self.imagePerson.image == UIImage(named: "QuestionMark.png"))
        if isImageQuestionMark == false && self.selectedPerson.imagePerson != self.imagePerson.image {
            self.selectedPerson.imagePerson = self.imagePerson.image
        } //end if
    } //end func
}