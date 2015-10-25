//
//  PersonTableViewController.swift
//  RandomPeople
//
//  Created by ryan on 10/26/15.
//  Copyright © 2015 while1.io. All rights reserved.
//

import UIKit
import CoreData

class RootViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext?
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let managedObjectContext = self.managedObjectContext else {
            return nil
        }
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
        fetchRequest.fetchBatchSize = 20
        let lastNameDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        let firstNameDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [lastNameDescriptor, firstNameDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: "Root")
        aFetchedResultsController.delegate = self
        return aFetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addNewPerson(sender: AnyObject) {
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        let newPerson = AWPerson.randomPersonInManagedObjectContext(managedObjectContext)
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Error = \(error)")
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RootViewController: NSFetchedResultsControllerDelegate {
    
}

extension RootViewController {
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let person = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? AWPerson {
            cell.textLabel?.text = person.fullName
            cell.detailTextLabel?.text = person.dateOfBirth?.description
        }
    }
}