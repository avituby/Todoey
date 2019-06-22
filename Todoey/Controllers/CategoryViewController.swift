//
//  CategoryViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 10/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
//            let newCategory = Category(context: self.context)
            let newCategory = Category()
            newCategory.name = textField.text!
//            newItem.done = false
//            self.categoriesArray.append(newCategory)
            self.save(category: newCategory, add:true)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
            print(alertTextField)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight=80
    }

    //mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
        return cell
    }

    //mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("goToItems Segue start")
        performSegue(withIdentifier: "goToItems", sender: self)
//        print("goToItems Segue end")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
//        print ("prepare for Seque 0")
        if let indexPath = tableView.indexPathForSelectedRow {
//            print ("prepare for Seque")
            destinationVC.selectedCategory = categories?[indexPath.row]
            print ("Selected Category = \(destinationVC.selectedCategory!.name)")
        }
    }
    
    //mark: - Data Manipulation Methods

    func loadCategories(){
        categories = realm.objects(Category.self)
    }

    
    func save(category: Category, add: Bool){
        do {
            try realm.write {
                if add {
                    realm.add(category)
                    tableView.reloadData()
                } else {
                    realm.delete(category)
                }
            }
        }   catch {
            print ("Error Saving context \(error)")
        }
    }
    
    
}

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if let selected_category = self.categories?[indexPath.row] {
                self.save(category: selected_category, add: false)
            }
            print ("Category Deleted")
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
//        options.transitionStyle = .border
        return options
    }
}
