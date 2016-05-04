//
//  ViewController.swift
//  Books2
//
//  Created by formateur on 03/05/2016.
//  Copyright © 2016 IPSSI. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var addBook: UIBarButtonItem!
    
    @IBAction func addNewBook(sender: AnyObject) {
        let book: Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        
        book.title = "Livre " + String(loadBooks().count)
        
        do {
            try managedObjectContext!.save()
        } catch let error as NSError {
            NSLog("Erreur : %@", error)
        }
        
        myTable.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext as NSManagedObjectContext
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        myTable.setEditing(editing, animated: animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return loadBooks().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        let book = loadBooks()[indexPath.row] as! Book
        cell?.textLabel!.text = book.title
        return cell!
    }
    
    func loadBooks() -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: "Book")
        var result = [AnyObject]()
        
        do {
            result = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let error as NSError {
            NSLog("Erreur : %@", error)
        }
        return result
    }
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext.deleteObject(loadBooks()[indexPath.row] as! Book)
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Erreur : %@", error)
            }
            tableView.reloadData()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    

    
}

