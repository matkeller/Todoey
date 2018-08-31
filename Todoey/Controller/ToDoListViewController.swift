//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Mat Keller on 8/28/18.
//  Copyright © 2018 Mat Keller. All rights reserved.
import UIKit

//See lecture 236:  Since we dragged and dropped a "Table View Controller" on to the story board we have far less plumbing to construct
//for the TableView.  We don't have to set up the IBOutlets, delegates or data source.

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()    //An array of Item objects
    //Get the file path to the users document folder
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print (dataFilePath)
        loadItems()
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
        self.saveItems()    
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Pop an alert with text field
        let alert = UIAlertController (title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Show "Add Item" button on alert and handle the action when it is pressed
        let action = UIAlertAction(title: "Add Item", style: .default) {
        (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        //Add the text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Change data in the Model
    
    func saveItems() {
        //Setup an encoder that can encode our data into a PropertyList
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath! )
        } catch {
            print ("Error encoding item array: \(error)")
        }
        tableView.reloadData()    //Reload the data to update the screen
    }
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print ("Error decoding item array: /(error)")
            }
        }
        
    }
}









