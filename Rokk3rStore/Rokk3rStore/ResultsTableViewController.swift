//
//  ResultsTableViewController.swift
//  Rokk3rStore
//
//  Created by Esteban Garcia Henao on 6/24/16.
//  Copyright © 2016 Esteban Garcia Henao. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var items: Dictionary<String, Array<String>>?
    let sections = ["Brand", "Clothing Type", "Result Query"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (items?.count)!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            
            return items!["Brand"]!.count
        }
        else if (section == 1) {
            
            return items!["Clothing Type"]!.count
        }
        else {
            
            return items!["Result Query"]!.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath)
        
        var item: String?
        
        if (indexPath.section == 0) {
            
            item = items!["Brand"]![indexPath.row]
        }
        else if (indexPath.section == 1) {
            
            item = items!["Clothing Type"]![indexPath.row]
        }
        else {
            
            item = items!["Result Query"]![indexPath.row]
        }
        
        cell.textLabel?.text = item

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }

}
