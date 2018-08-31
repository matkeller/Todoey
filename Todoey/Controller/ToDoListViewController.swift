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
    var itemArray = [Item]()    //An array of Item objects
    let defaults = UserDefaults.standard   //Place to store some data
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Milk"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Cheese"
        itemArray.append(newItem2)

        //Read data from defaults from previous sessions, but first be sure it exists
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
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
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary Operator refresher
        //  value = condition ? valueIfTRUE : valueIfFALSE
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }


    
    //MARK - TableView Delegate Methods
    
    //Use "didSelectRowAt" to determine an item was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print ("Selected item:  \(itemArray[indexPath.row])")
 
        //Flip the done property by setting it to the opposite (!) of what it is now
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()    //Reload the data to update the screen
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Pop an alert with text field
        let alert = UIAlertController (title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Show "Add Item" button on alert and handle the action when it is pressed
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //TODO - behavior for what happens when item is added
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()    //Reload the data to update the screen
        }
        
        //Add the text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}









