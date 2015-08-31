//
//  ViewController.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 3/28/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var match: Match?
    {
        didSet { }
    }
    
    //var savedMatch: NSManagedObject? = nil
    
    @IBOutlet var logDisplayTableView: UITableView!
    
    @IBOutlet var AButton: UIButton!
    
    @IBOutlet var BButton: UIButton!
    
    @IBAction func AGetPoint(sender: AnyObject) {
        if let match = self.match {
            match.AGetPoint()
            ASet.text = match.getASet()
            BSet.text = match.getBSet()
            AGame.text = match.getAGame()
            BGame.text = match.getBGame()
            AScore.text = match.getAScore()
            BScore.text = match.getBScore()
            logDisplayTableView.reloadData()
            setServer(match.currentServer)
            if match.isComplete() {
                matchCompleted()
            } else {
                saveMatch("Unfinished")
            }
        }
    }
    
    
    @IBAction func BGetPoint(sender: AnyObject) {
        if let match = self.match {
            match.BGetPoint()
            ASet.text = match.getASet()
            BSet.text = match.getBSet()
            AGame.text = match.getAGame()
            BGame.text = match.getBGame()
            AScore.text = match.getAScore()
            BScore.text = match.getBScore()
            logDisplayTableView.reloadData()
            setServer(match.currentServer)
            if match.isComplete() {
                matchCompleted()
            } else {
                saveMatch("Unfinished")
            }
        }
        
    }
    
    @IBAction func replayPoint(sender: AnyObject) {
        if let match = match {
            
            if match.completed {
                dispatch_async(dispatch_get_main_queue()) {
                    var alert = UIAlertController(
                        title: "Replay Point?",
                        message: "Your match just completed and has been recorded. Are you sure you want to replay the point.",
                        preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Replay Point", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                        self.deleteLast("Completed")
                        self.replay(match)
                    }) )
                    alert.addAction(UIAlertAction(
                        title: "Dismiss",
                        style: .Cancel,
                        handler: {(action: UIAlertAction!) -> Void in
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                replay(match)
            }
            
            
        }
        
    }
    
    @IBOutlet var replayButton: UIButton!
    
    func replay(match: Match) {
        match.replayPoint()
        saveMatch("Unfinished")
        ASet.text = match.getASet()
        BSet.text = match.getBSet()
        AGame.text = match.getAGame()
        BGame.text = match.getBGame()
        AScore.text = match.getAScore()
        BScore.text = match.getBScore()
        setServer(match.currentServer)
        AButton.enabled = true
        BButton.enabled = true
        logDisplayTableView.reloadData()
    }
    
    func deleteLast(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: entity)
        var error: NSError?
        let predicate = NSPredicate(format: "matchID == %@", argumentArray: [match!.matchID])
        fetchRequest.predicate = predicate
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
            managedContext.deleteObject(fetchedResults[0])
        }
    }
    
    func saveMatch(entity: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        if let match = match {
            let fetchRequest = NSFetchRequest(entityName: entity)
            var error: NSError?
            let predicate = NSPredicate(format: "matchID == %@", argumentArray: [match.matchID])
            fetchRequest.predicate = predicate
            
            if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
                if fetchedResults.count == 0 {
                    // add new
                    let entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: managedContext)
                    
                    let singleMatch = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                    
                    singleMatch.setValue(match, forKey: "matchRecord")
                    singleMatch.setValue(match.matchID, forKey: "matchID")
                    
                } else if fetchedResults.count == 1 {
                    // update
                    fetchedResults[0].setValue(match, forKey: "matchRecord")
                    
                } else {
                    println("error")
                }
            }
            //savedMatch = singleMatch
        }
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save image!")
        }
    }
    
    func matchCompleted() {
        AButton.enabled = false
        BButton.enabled = false
        deleteLast("Unfinished")
        saveMatch("Completed")
    }
    
    @IBOutlet var ASet: UILabel!
    
    @IBOutlet var BSet: UILabel!
    
    @IBOutlet var AGame: UILabel!
    
    @IBOutlet var BGame: UILabel!
    
    @IBOutlet var AScore: UILabel!
    
    @IBOutlet var BScore: UILabel!
    
    @IBOutlet var AName: UILabel!
    
    @IBOutlet var BName: UILabel!
    
    func menu(sender: UIButton!) {
        performSegueWithIdentifier("menu", sender: self)
    }
    
    func generateNavigationItems() {
        
        let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 28))
        saveButton.setTitle("Menu", forState: UIControlState.Normal)
        saveButton.addTarget(self, action: "menu:", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.layer.borderWidth = 0
        saveButton.layer.cornerRadius = 5.0
        saveButton.titleLabel?.font = UIFont(name: "STHeitiSC-Medium", size: 14)
        
        let gradient = CAGradientLayer()
        gradient.frame = saveButton.bounds
        gradient.cornerRadius = 5.0
        gradient.colors =
            [UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor,
                UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).CGColor,
                UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor]
        saveButton.layer.insertSublayer(gradient, atIndex: 0)
        
        let saveItem = UIBarButtonItem(customView: saveButton)
        self.navigationItem.leftBarButtonItem = saveItem
    }
    
    @IBOutlet var serverA: UIImageView!
    
    @IBOutlet var serverB: UIImageView!
    
    func setServer(server: Int) {
        if server == 0 {
            serverA.layer.borderColor = UIColor.greenColor().CGColor
            serverB.layer.borderColor = UIColor.grayColor().CGColor
        } else {
            serverB.layer.borderColor = UIColor.greenColor().CGColor
            serverA.layer.borderColor = UIColor.grayColor().CGColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        generateNavigationItems()
        
        AButton.layer.borderWidth = 1
        BButton.layer.borderWidth = 1
        replayButton.layer.borderWidth = 1
        AButton.layer.borderColor = UIColor.grayColor().CGColor
        BButton.layer.borderColor = UIColor.grayColor().CGColor
        replayButton.layer.borderColor = UIColor.grayColor().CGColor
        replayButton.layer.cornerRadius = 25
        
        serverA.layer.cornerRadius = 16
        serverB.layer.cornerRadius = 16
        serverA.layer.borderWidth = 2
        serverB.layer.borderWidth = 2
        serverA.layer.masksToBounds = true
        serverB.layer.masksToBounds = true
        
        logDisplayTableView.delegate = self
        logDisplayTableView.dataSource = self
        self.view.backgroundColor = UIColor.blackColor()
        if let match = self.match {
            AName.text = match.playerA
            BName.text = match.playerB
            AButton.setTitle(match.playerA + " WIN the Point", forState: UIControlState.Normal)
            BButton.setTitle(match.playerB + " WIN the Point", forState: UIControlState.Normal)
            
            if let imageID = match.AImage {
                if let imageData = getImage(imageID) {
                    serverA.image = UIImage(data: imageData)
                }
            }
            if let imageID = match.BImage {
                if let imageData = getImage(imageID) {
                    serverB.image = UIImage(data: imageData)
                }
            }
            setServer(match.currentServer)
            ASet.text = match.getASet()
            BSet.text = match.getBSet()
            AGame.text = match.getAGame()
            BGame.text = match.getBGame()
            AScore.text = match.getAScore()
            BScore.text = match.getBScore()
            
            
            logDisplayTableView.reloadData()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getImage(imageID: String) -> NSData? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        if let match = match {
            let fetchRequest = NSFetchRequest(entityName: "Image")
            var error: NSError?
            let predicate = NSPredicate(format: "imageID == %@", argumentArray: [imageID])
            fetchRequest.predicate = predicate
            
            if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject] {
                if fetchedResults.count == 1 {
                    return fetchedResults[0].valueForKey("imageData") as? NSData
                
                } else {
                    println("error")
                }
            }
            //savedMatch = singleMatch
        }
        
        return nil
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("here")
        if let match = self.match {
            return match.points.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("log", forIndexPath: indexPath) as! LogTableViewCell
        cell.logLabel.text = match!.points[match!.points.count - indexPath.row - 1].log
        cell.scoreLabel.text = match!.points[match!.points.count - indexPath.row - 1].scoreDisplay
        cell.gameScoreLabel.text = match!.points[match!.points.count - indexPath.row - 1].setDisplay
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }


}

