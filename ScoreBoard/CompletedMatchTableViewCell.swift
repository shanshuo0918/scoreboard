//
//  CompletedMatchTableViewCell.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/9/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class CompletedMatchTableViewCell: UITableViewCell {
    
    @IBOutlet var playerA: UILabel!
    
    @IBOutlet var playerB: UILabel!
    
    @IBOutlet var winorloss: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var AImage: UIImageView!
    
    @IBOutlet var BImage: UIImageView!
    
    
    var match: Match? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        AImage.layer.cornerRadius = 22
        BImage.layer.cornerRadius = 22
        AImage.layer.borderWidth = 2
        BImage.layer.borderWidth = 2
        AImage.layer.masksToBounds = true
        BImage.layer.masksToBounds = true
        
        if let match = match {
            playerA.text = match.playerA
            playerB.text = match.playerB
            scoreLabel.text = match.points.last?.setDisplay
            if match.winner == 0 {
                winorloss.text = "defeat"
            } else {
                winorloss.text = "lose to"
            }
            
            if let imageID = match.AImage {
                if let imageData = getImage(imageID) {
                    AImage.image = UIImage(data: imageData)
                }
            }
            if let imageID = match.BImage {
                if let imageData = getImage(imageID) {
                    AImage.image = UIImage(data: imageData)
                }
            }
            
            var timeFormatter = NSDateFormatter()
            timeFormatter.dateStyle = NSDateFormatterStyle.LongStyle
            timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            timeLabel.text = timeFormatter.stringFromDate(match.startTime)
        }
    }
    
    func getImage(imageID: String) -> NSData? {
        println("find")
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
