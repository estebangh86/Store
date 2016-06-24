//
//  ViewController.swift
//  Rokk3rStore
//
//  Created by Esteban Garcia Henao on 6/24/16.
//  Copyright © 2016 Esteban Garcia Henao. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func searchButtonTouched(sender: AnyObject) {
        
        let searchQueries = searchField.text?.capitalizedString
        
        let searchQueriesArray = searchQueries!.characters.split{$0 == " "}.map(String.init)
        let searchSet = Set<String>(searchQueriesArray)
        
        let queriesArray = Array(searchSet)
        
        let results = ModelManager.search(queriesArray)
        
        performSegueWithIdentifier("showResults", sender: results)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let resultsVC = segue.destinationViewController as! ResultsTableViewController
        
        resultsVC.items = sender as? Dictionary<String, Array<String>>
    }

}

