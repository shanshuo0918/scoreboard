//
//  CourtSurfaceTableViewController.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 7/31/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

protocol CourtSurfaceTableViewControllerDelegate {
    func setCourtSurface(controller: CourtSurfaceTableViewController, courtSurface: Int)
}

class CourtSurfaceTableViewController: UITableViewController {

    let hard: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    let clay: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
    let grass: NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
    let carpet: NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
    
    var courtSurface = 0
    
    var delegate: CourtSurfaceTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        let indexPath: NSIndexPath = NSIndexPath(forRow: courtSurface, inSection: 0)
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(hard)?.accessoryType = UITableViewCellAccessoryType.None
        tableView.cellForRowAtIndexPath(clay)?.accessoryType = UITableViewCellAccessoryType.None
        tableView.cellForRowAtIndexPath(grass)?.accessoryType = UITableViewCellAccessoryType.None
        tableView.cellForRowAtIndexPath(carpet)?.accessoryType = UITableViewCellAccessoryType.None
        if let delegate = delegate {
            delegate.setCourtSurface(self, courtSurface: indexPath.row)
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
