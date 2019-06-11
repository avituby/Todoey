//
//  CategoryViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 10/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit
import RealmSwift

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
            self.save(category: newCategory)
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

    }

    //mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
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

    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        }   catch {
            print ("Error Saving context \(error)")
        }
        tableView.reloadData()
    }
    
    
}
