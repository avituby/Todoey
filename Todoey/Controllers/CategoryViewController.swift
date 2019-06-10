//
//  CategoryViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 10/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoriesArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
//            newItem.done = false
            self.categoriesArray.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    //mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        return cell
    }

    //mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("goToItems Segue start")
        performSegue(withIdentifier: "goToItems", sender: self)
        print("goToItems Segue end")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        print ("prepare for Seque 0")
        if let indexPath = tableView.indexPathForSelectedRow {
            print ("prepare for Seque")
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
            print ("Selected Category = \(destinationVC.selectedCategory!.name)")
        }
    }
    
    //mark: - Data Manipulation Methods

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print ("Error Fetching Items \(error)")
        }
        tableView.reloadData()
    }

    func saveCategories(){
        do {
            try context.save()
        }   catch {
            print ("Error Saving context \(error)")
        }
        tableView.reloadData()
    }
    
    
}
