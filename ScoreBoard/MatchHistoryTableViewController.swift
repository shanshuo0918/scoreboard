//
//  MatchHistoryTableViewController.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/3/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class MatchHistoryTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    var matchs: [NSManagedObject] = []
    
    var mode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView: UIImageView = UIImageView(image: UIImage(named: "image-dark")!)
        backgroundView.frame = self.tableView.frame
        self.tableView.backgroundView = backgroundView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.tableView.backgroundColor = UIColor.clearColor()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        generateNavigationItems()
        getData("Completed")
        self.tableView.reloadData()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func back(sender: UIButton!) {
        performSegueWithIdentifier("back", sender: self)
    }
    
    func newMatch(sender: UIButton!) {
        performSegueWithIdentifier("newmatch", sender: self)
    }
    
    func generateNavigationItems() {
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 28))
        backButton.setTitle("Menu", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.layer.borderWidth = 0
        backButton.layer.cornerRadius = 5.0
        //backButton.layer.borderColor = UIColor.grayColor().CGColor
        backButton.titleLabel?.font = UIFont(name: "STHeitiSC-Medium", size: 14)
        
        let gradient = CAGradientLayer()
        gradient.frame = backButton.bounds
        gradient.cornerRadius = 5.0
        gradient.colors =
            [UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor,
            UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).CGColor,
            UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor]
        backButton.layer.insertSublayer(gradient, atIndex: 0)
        
        let backItem = UIBarButtonItem(customView: backButton)
        
        
        let newButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 28))
        newButton.setTitle("New", forState: UIControlState.Normal)
        newButton.addTarget(self, action: "newMatch:", forControlEvents: UIControlEvents.TouchUpInside)
        newButton.layer.borderWidth = 0
        newButton.layer.cornerRadius = 5.0
        newButton.titleLabel?.font = UIFont(name: "STHeitiSC-Medium", size: 14)
        
        let gradient2 = CAGradientLayer()
        gradient2.frame = backButton.bounds
        gradient2.cornerRadius = 5.0
        gradient2.colors =
            [UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor,
                UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).CGColor,
                UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor]
        newButton.layer.insertSublayer(gradient2, atIndex: 0)
        
        
        let newItem = UIBarButtonItem(customView: newButton)
        
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem = newItem
    }
    
    
    func getData(entity: String) {
        println(matchs.count)
        matchs.removeAll(keepCapacity: false)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        var error: NSError?
        
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
            matchs = fetchedResults
            /*for result in fetchedResults {
                completedMatch.append(result.valueForKey("matchRecord") as! Match)
            }*/
        }
        println(matchs.count)
    }
    
    /*func deleteObject(index: Int) {
        println(completedMatch.count)
        completedMatch.removeAll(keepCapacity: false)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        managedContext.deleteObject(
        var error: NSError?
        
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
            for result in fetchedResults {
                completedMatch.append(result.valueForKey("matchRecord") as! Match)
            }
        }
        println(completedMatch.count)
    }*/


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        return matchs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("button", forIndexPath: indexPath) as! ButtonTableViewCell
            cell.delegate = self
            // Configure the cell...
            cell.backgroundColor = UIColor.clearColor()
            return cell
        } else {
            if mode {
                let cell = tableView.dequeueReusableCellWithIdentifier("unfinished", forIndexPath: indexPath) as! UnfinishedMatchTableViewCell
                if let match = matchs[indexPath.row].valueForKey("matchRecord") as? Match {
                    cell.match = match
                }
                cell.backgroundColor = UIColor.clearColor()
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("completed", forIndexPath: indexPath) as! CompletedMatchTableViewCell
                if let match = matchs[indexPath.row].valueForKey("matchRecord") as? Match {
                    cell.match = match
                }
                cell.backgroundColor = UIColor.clearColor()
                return cell
            }
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            //let fetchRequest = NSFetchRequest(entityName: entity)
            managedContext.deleteObject(matchs[indexPath.row])
            var error: NSError?
            managedContext.save(&error)
            
            matchs.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 34
        } else {
            return 90
        }
    }
    
    
    func showUnfinished(controller: ButtonTableViewCell) {
        mode = true
        getData("Unfinished")
        self.tableView.reloadData()
    }
    
    func showCompleted(controller: ButtonTableViewCell) {
        mode = false
        getData("Completed")
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "resume" {
            let cell = sender as! UnfinishedMatchTableViewCell
            var destination = segue.destinationViewController as? UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController
            }
            if let mvc = destination as? ViewController {
                mvc.match = cell.match
                println(mvc.match!.numberOfSets)
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
