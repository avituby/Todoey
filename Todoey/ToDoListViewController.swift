//
//  ViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 07/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Make Sushi", "Sleep Well"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
}
