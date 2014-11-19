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

    //Image picker controller: source of Person's image
    var imagePickerController = UIImagePickerController()
    
    //Selected Person:
    var selectedPerson = Person()
    
    //Function: Set view for selected Person.
    override func viewDidLoad() {
        //Super:
        super.viewDidLoad()
        
        //Title: set to selected Person's name.
        self.title = selectedPerson.getFullName()
        
        //Set text field delegates.
        self.textNameFirst.delegate = self
        self.textNameLast.delegate = self
        
        //Set image picker controller delegate.
        self.imagePickerController.delegate = self
        
        //Display names of selected Person in text fields.
        textNameFirst.text = selectedPerson.nameFirst
        textNameLast.text = selectedPerson.nameLast
        //Display image of selected Person, if any, in image view.
        if selectedPerson.imagePerson != nil {
            imagePerson.image = selectedPerson.imagePerson
        }
    }
    
    //Function: Dismiss keyboard when user presses Return.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Dismiss keyboard.
        textField.resignFirstResponder()
        //Return function value [non-functional here].
        return true
    }
    
    //Function: Camera button pressed. Show camera to allow user to take a photo of Person.
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            //Set image picker controller source.
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //Allow editing of image.
            imagePickerController.allowsEditing = true
            //Present camera to user.
            presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //Function: Set camera image, after user has selected image, to image on view controller. Dismiss camera.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //Retrieve camera [image picker controller] image.
        let imageSelected = info[UIImagePickerControllerEditedImage] as UIImage
        //Set view controller's image to camera's image.
        imagePerson.image = imageSelected
        //Dismiss camera.
        imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Function: Update selected Person's properties, if changed.
    override func viewWillDisappear(animated: Bool) {
        //Super:
        super.viewWillDisappear(animated)
        
        //Update selected Person's properties, if changed.
        if selectedPerson.nameFirst != textNameFirst.text {selectedPerson.nameFirst = textNameFirst.text}
        if selectedPerson.nameLast != textNameLast.text {selectedPerson.nameLast = textNameLast.text}
        if selectedPerson.imagePerson != imagePerson.image {selectedPerson.imagePerson = imagePerson.image}
    }
}