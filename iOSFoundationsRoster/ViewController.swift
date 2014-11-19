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
    //Index path to selected Person:
    var indpathSelectedPerson: NSIndexPath?
    
    //Function: Initialize page (including navigation bar appearance). Add Persons to Person array to display in table.
    override func viewDidLoad() {
        //Super:
        super.viewDidLoad()
        
        //Navigation bar appearance:
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "EuphemiaUCAS", size: 18)!]
        //Navigation bar back button appearance:
        var buttonCustom = UIBarButtonItem()
        buttonCustom.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "EuphemiaUCAS", size: 18)!, NSForegroundColorAttributeName: UIColor.blackColor()], forState: UIControlState.Normal)
        navigationItem.backBarButtonItem = buttonCustom
        
        //Title:
        self.title = "Roster"
        
        //Load Persons.
        loadPersonsFromRosterPList()
        
        //Set table data source & delegate.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    //Function: load Persons from Roster plist.
    func loadPersonsFromRosterPList() {
        //Plist contains an array of dictionaries; each dictionary represents 1 Person.
        
        //PList path:
        let pathPList = NSBundle.mainBundle().pathForResource("Roster", ofType: "plist")
        
        //Load array of plist contents into Person array.
        if let plistArray = NSArray(contentsOfFile: pathPList!) {
            for plistUnit in plistArray {
                if let personDictionary = plistUnit as? NSDictionary {
                    let nameFirst = personDictionary["NameFirst"] as String
                    let nameLast = personDictionary["NameLast"] as String
                    myPersons.append(Person(nameFirst: nameFirst, nameLast: nameLast))
                }
            }
        }
    }
    
    //Function: Set table row count.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPersons.count
    }
    
    //Function: Set table cell contents.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Cell:
        var cell = tableView.dequeueReusableCellWithIdentifier("PERSON_CELL", forIndexPath: indexPath) as PersonTableViewCell
        //Index path of row/Person.
        var personCurrent = myPersons[indexPath.row]
        
        //Set cell contents.
        //Cell image: Person's image
        if personCurrent.imagePerson != nil {cell.imagePerson.image = personCurrent.imagePerson}
        //Cell text: Person's name
        cell.labelPersonName.text = personCurrent.getFullName()
        
        //Return cell.
        return cell
    }
    
    //Function: Prepare for segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Super:
        super.prepareForSegue(segue, sender: sender)
        
        //Prepare for segue:
        if segue.identifier == "DETAIL_SEGUE" {
            //Detail view controller: will show details of Person selected.
            let personDetailViewController = segue.destinationViewController as DetailViewController
            //Selected Person:
            indpathSelectedPerson = tableView.indexPathForSelectedRow() //Index path
            var selectedPerson = myPersons[indpathSelectedPerson!.row] //Person
            //Set detail view controller's selected Person.
            personDetailViewController.selectedPerson = selectedPerson
        }
    }
    
    //Function: Reload table view cell data when View Controller reappears.
    override func viewWillAppear(animated: Bool) {
        //Super:
        super.viewWillAppear(animated)
        
        //Update selected Person's table view cell (name).
        if let testSelectedPerson = indpathSelectedPerson {
            tableView.reloadRowsAtIndexPaths([testSelectedPerson], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
}