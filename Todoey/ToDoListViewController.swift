//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Mat Keller on 8/28/18.
//  Copyright © 2018 Mat Keller. All rights reserved.
//

import UIKit 

//See lecture 236:  Since we dragged and dropped a "Table View Controller" on to the story board we
//have far less plumbing to construct for the TableView.  We don't have to set up the IBOutlets, delegates
//or data source.


class ToDoListViewController: UITableViewController {
    let itemArray = ["Bread", "Milk", "Eggs"]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    //MARK - Tableview Datasource Methods

    //Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //To find this quickly search for "cellForRowAt"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        //The "tableView" global variable comes with subclassing or using the Table View Contoller (UITableViewController)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }


    
    //MARK - TableView Delegate Methods
    
    //Use "didSelectRowAt" to determine an item was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print ("Selected item:  \(itemArray[indexPath.row])")
        
        //Add and take away the checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }



}

