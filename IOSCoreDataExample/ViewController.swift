//
//  ViewController.swift
//  IOSCoreDataExample
//
//  Created by Shikha Gupta on 28/11/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    var names : [String] = []

    
    
    let tableViewCallIdentifer = "TextCell"

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewItem(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCallIdentifer, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
       print("Inside Deselect \(names[row])")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        print("Inside select \(names[row])")
    }
    
}

