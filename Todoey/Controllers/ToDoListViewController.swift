//
//  ViewController.swift
//  Todoey
//
//  Created by DAVID AVI TUBI on 07/06/2019.
//  Copyright © 2019 DAVID AVI TUBI. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
//    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
            print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        moved to didSet of selectedCategory loadItems()
        
//        print(dataFilePath)
//        loadData()

//        let newItem = Item()
//        newItem.title = "Find Mike 1"
//        itemArray.append(newItem)
//        let newItem1 = Item()
//        newItem1.title = "Find Mike 2"
//        newItem1.done = true
//        itemArray.append(newItem1)
//        let newItem2 = Item()
//        newItem2.title = "Find Mike 3"
//        itemArray.append(newItem2)

//        if let items = self.defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
//        searchBar.delegate = self
        print ("View Did Load")
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView DataSourceMethod
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ?.checkmark : .none
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print (itemArray[indexPath!.row] )
//        itemArray[indexPath.row].setValue(true, forKey: "done")

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        print( tableView.cellForRow(at: indexPath!)?.accessoryType.rawValue)
//        if  tableView.cellForRow(at: indexPath!)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath!)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath!)?.accessoryType = .checkmark
//        }
        saveItemsData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - BARBUTTON METHODS
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
//            self.itemArray.append(Item(title: textField.text!,done:false))
            self.saveItemsData()
//            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "(parentCategory.name MATCHES %@)", selectedCategory!.name!)
        if let additionalPredicate=predicate {
                request.predicate = NSCompoundPredicate (andPredicateWithSubpredicates:  [categoryPredicate, additionalPredicate])
        } else {
                request.predicate = categoryPredicate
        }
        do {
            itemArray = try context.fetch(request)
        } catch {
            print ("Error Fetching Items \(error)")
        }
        tableView.reloadData()
    }
    
    func saveItemsData(){
        do {
            try context.save()
        }   catch {
            print ("Error Saving context \(error)")
        }
        tableView.reloadData()
    }
    

//    func saveItemsData(){
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//        }   catch {
//            print ("Error Encoding itemArray, \(error)")
//        }
//        tableView.reloadData()
//    }

//    func loadData(){
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            }   catch {
//                print ("Error Encoding itemArray, \(error)")
//            }
//        }
////        tableView.reloadData()
//    }

}

//MARK: - SearchBar Methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        if searchBar.text!.count>0 {
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        }
        loadItems(with: request, predicate: predicate)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
