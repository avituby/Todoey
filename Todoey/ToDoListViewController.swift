//
//  ViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 07/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Make Sushi", "Sleep Well"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = self.defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        print ("View Did Load")
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView DataSourceMethod
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath?) {
        print (itemArray[indexPath!.row] )
//        print( tableView.cellForRow(at: indexPath!)?.accessoryType.rawValue)
        if  tableView.cellForRow(at: indexPath!)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath!)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath!)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath!, animated: true)
        
    }
    
    //MARK - BARBUTTON METHODS
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

