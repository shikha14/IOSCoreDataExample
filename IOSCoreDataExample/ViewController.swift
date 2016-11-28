//
//  ViewController.swift
//  IOSCoreDataExample
//
//  Created by Shikha Gupta on 28/11/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let entityName : String = "Person"
    let keyColName : String = "name"
    

    
  //  var names : [String] = []
    
    var people : [NSManagedObject] = []

    
    
    let tableViewCallIdentifer = "TextCell"

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name", message: "Add new name", preferredStyle: .alert)
        alert.addTextField()
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { action in
            guard let textfield = alert.textFields?.first ,
                let nameToSave = textfield.text else {
                    return
            }
            
            //self.names.append(nameToSave)
            self.savePerson(name: nameToSave)
            self.tableView.reloadData()

        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        
        present(alert, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        people = fetchPeople()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return names.count
         return people.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCallIdentifer, for: indexPath)
//        cell.textLabel?.text = names[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       // let row = indexPath.row
       //print("Inside Deselect \(names[row])")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let row = indexPath.row
       // print("Inside select \(names[row])")
    }
    
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return (appDelegate?.persistentContainer.viewContext)!
    }
    
    func savePerson(name : String)
    {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        let person = NSManagedObject(entity:entity!, insertInto: context)
        
        person.setValue(name, forKey: keyColName)
        
        do{
            try context.save()
            people.append(person)
        }catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func fetchPeople() -> [NSManagedObject]
    {
        var list : [NSManagedObject] = []
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
           list = try context.fetch(fetchRequest)
            
        }catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return list
    
    }
    
}

