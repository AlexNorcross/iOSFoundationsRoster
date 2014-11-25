//
//  ViewController.swift
//  iOS Foundations Roster
//
//  Created by Alexandra Norcross on 10/30/14.
//  Copyright (c) 2014 Alexandra Norcross. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //Table: to display Persons
    @IBOutlet weak var tableView: UITableView!
    
    //Person array:
    var myPersons = [Person]()
    //Index path to selected Person: to refresh row of selected Person
    var indpathSelectedPerson: NSIndexPath?
    
    //Function: Initialize page (including navigation bar). Add Persons to Person array to display in table.
    override func viewDidLoad() {
        //Super:
        super.viewDidLoad()
        
        //Title:
        self.title = "Roster"
        
        //Navigation bar appearance:
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "EuphemiaUCAS", size: 18)!]
        //Navigation bar back button appearance:
        var buttonCustom = UIBarButtonItem()
        buttonCustom.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "EuphemiaUCAS", size: 16)!, NSForegroundColorAttributeName: UIColor.blackColor()], forState: UIControlState.Normal)
        self.navigationItem.backBarButtonItem = buttonCustom
        
        //Set table data source & delegate.
        self.tableView.dataSource = self
        self.tableView.delegate = self

        //Load Persons: if archive exists, load from archive; else, load from plist (and save Persons to archive).
        if let peopleFromArchive = loadPersonsFromArchive() as [Person]? { //Load from archive.
            self.myPersons = peopleFromArchive
        } else { //Load from plist; and save to archive.
            loadPersonsFromRosterPList()
            savePersonsToArchive()
        } //end if
        
        //User Defaults: first-time run key (set if first run)
        var runFirstTime = NSUserDefaults.standardUserDefaults().boolForKey("runFirstTime") //Returns value or false (if key does not exist).
        if runFirstTime == false {
            //First run: set value to indicate app has already run once.
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "runFirstTime")
        } //end if
    } //end func
    
    //Function: Loads Persons from archive.
    func loadPersonsFromArchive() -> [Person]? {
        //Documents/Archive path:
        let pathDocuments = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let pathArchive = pathDocuments + "/archive"
        
        //Load Persons, if any, from archive.
        if let peopleFromArchive = NSKeyedUnarchiver.unarchiveObjectWithFile(pathArchive) as? [Person] {
            return peopleFromArchive
        } else {
            return nil
        } //end if
    } //end func
    
    //Function: Saves Persons to archive.
    func savePersonsToArchive() {
        //Documents/Archive path:
        let pathDocuments = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let pathArchive = pathDocuments + "/archive"
        
        //Save Persons to archive.
        NSKeyedArchiver.archiveRootObject(self.myPersons, toFile: pathArchive)
    } //end func
    
    //Function: Loads Persons from Roster plist.
    func loadPersonsFromRosterPList() {
        //PList contains an array of dictionaries
        //  each dictionary represents 1 Person
        //      each dictionary key represents a property of the Person.
        
        //PList path:
        let pathPList = NSBundle.mainBundle().pathForResource("Roster", ofType: "plist")
        
        //Load plist contents.
        if let plistArray = NSArray(contentsOfFile: pathPList!) { //Array exists.
            for plistUnit in plistArray {
                if let personDictionary = plistUnit as? NSDictionary { //Dictionary exists.
                    //Person properties:
                    let nameFirst = personDictionary["NameFirst"] as String
                    let nameLast = personDictionary["NameLast"] as String
                    //Add Person to Persons array.
                    self.myPersons.append(Person(nameFirst: nameFirst, nameLast: nameLast, isStudent: false))
                } //end if
            } //end for
        } //end if
    } //end func
    
    //Function: Set table row count.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myPersons.count
    } //end func
    
    //Function: Set table cell contents.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Cell:
        var cell = tableView.dequeueReusableCellWithIdentifier("PERSON_CELL", forIndexPath: indexPath) as PersonTableViewCell
        //Index path of row/Person.
        var personCurrent = self.myPersons[indexPath.row]
        
        //Set cell: Person's image and name
        if personCurrent.imagePerson != nil {
            cell.imagePerson.image = personCurrent.imagePerson
        } //end if
        cell.labelPersonName.text = personCurrent.getFullName()
        
        //Return cell.
        return cell
    } //end func
    
    //Function: Prepare for segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Super:
        super.prepareForSegue(segue, sender: sender)
        
        //Prepare for segue:
        if segue.identifier == "DETAIL_SEGUE" {
            //Detail view controller: will show details of Person selected.
            let personDetailViewController = segue.destinationViewController as DetailViewController
            //Selected Person:
            self.indpathSelectedPerson = self.tableView.indexPathForSelectedRow() //Index path
            var selectedPerson = self.myPersons[self.indpathSelectedPerson!.row] //Person
            //Set detail view controller's selected Person.
            personDetailViewController.selectedPerson = selectedPerson
        } //end if
    } //end func
    
    //Function: Reload table view cell data when View Controller reappears.
    override func viewWillAppear(animated: Bool) {
        //Super:
        super.viewWillAppear(animated)
        
        //Update selected Person's table view cell.
        if let testSelectedPerson = self.indpathSelectedPerson {
            self.tableView.reloadRowsAtIndexPaths([testSelectedPerson], withRowAnimation: UITableViewRowAnimation.None)
        } //end if
        
        //Save Persons.
        savePersonsToArchive()
    } //end func
}