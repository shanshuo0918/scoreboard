//
//  SettingTableViewController.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 3/28/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class SettingTableViewController: UITableViewController, NumberOfSetTableViewControllerDelegate, FinalSetRuleTableViewControllerDelegate, CourtSurfaceTableViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var numberOfSet: Int = 1
    
    @IBOutlet var numberOfSetLabel: UILabel!
    
    @IBOutlet var WithAdvantage: UISwitch!
    
    var finalSetRule: Int = 1
    
    @IBOutlet var finalSetRuleLabel: UILabel!
    
    var courtSurface: Int = 0
    
    @IBOutlet var surfaceLabel: UILabel!
    
    @IBOutlet var playerA: UITextField!
    
    @IBOutlet var playerB: UITextField!
    
    @IBOutlet var Server: UISegmentedControl!
    
    @IBOutlet var addPhotoAButton: UIButton!
    
    @IBOutlet var addPhotoBButton: UIButton!
    
    var addPhotoA: Bool = true
    
    var AImage: String? = nil
    
    var BImage: String? = nil
    
    func saveImage(image: UIImage, imageID: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Image", inManagedObjectContext: managedContext)
        let singleMatch = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        singleMatch.setValue(UIImageJPEGRepresentation(image, 0.2), forKey: "imageData")
        singleMatch.setValue(imageID, forKey: "imageID")
        println("saved")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        let imageID = NSUUID().UUIDString
        saveImage(image!, imageID: imageID)
        if addPhotoA {
            // add photoA
            AImage = imageID
            addPhotoAButton.setImage(image, forState: UIControlState.Normal)
        } else {
            // add photoB
            BImage = imageID
            addPhotoBButton.setImage(image, forState: UIControlState.Normal)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func addPhotoA(sender: UIButton) {
        addPhotoA = true
        var alert = UIAlertController(
            title: "Add your photo",
            message: "Please select your photo for playerA!",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.mediaTypes = [kUTTypeImage]
                picker.delegate = self
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Select from Album", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.mediaTypes = [kUTTypeImage]
                picker.delegate = self
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: nil)
            }
        }))
        
        /*alert.addAction(UIAlertAction(title: "Select from previous photos", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("selectimage", sender: self)
        }))*/
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addPhotoB(sender: UIButton) {
        addPhotoA = false
        var alert = UIAlertController(
            title: "Add your photo",
            message: "Please select your photo for playerA!",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.mediaTypes = [kUTTypeImage]
                picker.delegate = self
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Select from Album", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.mediaTypes = [kUTTypeImage]
                picker.delegate = self
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: nil)
            }
        }))
        
        /*alert.addAction(UIAlertAction(title: "Select from previous photos", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("selectimage", sender: self)
        }))*/
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func back(sender: UIButton!) {
        performSegueWithIdentifier("back", sender: self)
    }
    
    func generateNavigationItems() {
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 28))
        backButton.setTitle("Menu", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.layer.borderWidth = 0
        backButton.layer.cornerRadius = 5.0
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
        
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView: UIImageView = UIImageView(image: UIImage(named: "image-dark")!)
        backgroundView.frame = self.tableView.frame
        self.tableView.backgroundView = backgroundView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        generateNavigationItems()
        addPhotoAButton.imageView?.layer.cornerRadius = 15
        addPhotoBButton.imageView?.layer.cornerRadius = 15
        addPhotoAButton.imageView?.backgroundColor = UIColor.lightGrayColor()
        addPhotoBButton.imageView?.backgroundColor = UIColor.lightGrayColor()
        addPhotoAButton.imageView?.layer.masksToBounds = true
        addPhotoBButton.imageView?.layer.masksToBounds = true
        
        AName.layer.borderColor = UIColor.grayColor().CGColor
        AName.layer.borderWidth = 1
        AName.layer.cornerRadius = 5
        BName.layer.borderColor = UIColor.grayColor().CGColor
        BName.layer.borderWidth = 1
        BName.layer.cornerRadius = 5
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "numberofset" {
            var destination = segue.destinationViewController as? UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController
            }
            if let mvc = destination as? NumberOfSetTableViewController {
                mvc.numberOfSet = numberOfSet
                mvc.delegate = self
            }
        }
        
        if segue.identifier == "finalsetrule" {
            var destination = segue.destinationViewController as? UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController
            }
            if let mvc = destination as? FinalSetRuleTableViewController {
                mvc.finalSetRule = finalSetRule
                mvc.delegate = self
            }
        }
        
        if segue.identifier == "courtsurface" {
            var destination = segue.destinationViewController as? UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController
            }
            if let mvc = destination as? CourtSurfaceTableViewController {
                mvc.courtSurface = courtSurface
                mvc.delegate = self
            }
        }
        
        if segue.identifier == "start" {
            let numOfSets = numberOfSet
            var withAdv = 0
            if WithAdvantage.on {
                withAdv = 1
            }
            let finalSet = finalSetRule
            let type = numOfSets * 8 + finalSet * 2 + withAdv
            
            var playerAName = playerA.text
            if playerAName == "" {
                playerAName = "Player A"
            }
            var playerBName = playerB.text
            if playerBName == "" {
                playerBName = "Player B"
            }
            
            var destination = segue.destinationViewController as? UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController
            }
            if let mvc = destination as? ViewController {
                mvc.match = Match(playerA: playerAName, playerB: playerBName, AImage: AImage, BImage: BImage, server: Server.selectedSegmentIndex, type: type)
                println(mvc.match)
            }
        }
        
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    func setFinalSetRule(controller: FinalSetRuleTableViewController, finalSetRule: Int) {
        self.finalSetRule = finalSetRule
        switch finalSetRule {
        case 0:
            finalSetRuleLabel.text = "Super Tie Break"
        case 1:
            finalSetRuleLabel.text = "Normal Set"
        case 2:
            finalSetRuleLabel.text = "Advantage Set"
        default:
            break;
        }
    }
    
    func setNumberOfSet(controller: NumberOfSetTableViewController, numberOfSet: Int) {
        self.numberOfSet = numberOfSet
        switch numberOfSet {
        case 0:
            numberOfSetLabel.text = "One Set"
        case 1:
            numberOfSetLabel.text = "Three Set"
        case 2:
            numberOfSetLabel.text = "Five Set"
        default:
            break;
        }
    }
    
    func setCourtSurface(controller: CourtSurfaceTableViewController, courtSurface: Int) {
        self.courtSurface = courtSurface
        switch courtSurface {
        case 0:
            surfaceLabel.text = "Hard"
        case 1:
            surfaceLabel.text = "Clay"
        case 2:
            surfaceLabel.text = "Grass"
        case 3:
            surfaceLabel.text = "Carpet"
        default:
            break;
        }
    }
    

    @IBOutlet var AName: UITextField!
    
    @IBOutlet var BName: UITextField!
    
}
