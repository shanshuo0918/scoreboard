//
//  ButtonTableViewCell.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/18/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func showUnfinished(controller: ButtonTableViewCell)
    func showCompleted(controller: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet var unfinishedMatchButton: UIButton!
    
    @IBOutlet var completedMatchButton: UIButton!
    
    @IBAction func unfinishedMatch(sender: UIButton) {
        
        unfinishedMatchButton.layer.backgroundColor = UIColor.lightGrayColor().CGColor //UIColor(red: 14.0/255.0, green: 174.0/255.0, blue: 3.0/255.0, alpha: 1.0).CGColor
        completedMatchButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        completedMatchButton.layer.backgroundColor = UIColor.clearColor().CGColor
        unfinishedMatchButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        if let delegate = delegate {
            delegate.showUnfinished(self)
        }
    }
    
    @IBAction func completedMatch(sender: UIButton) {
        
        unfinishedMatchButton.layer.backgroundColor = UIColor.clearColor().CGColor
        completedMatchButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        completedMatchButton.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        unfinishedMatchButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        if let delegate = delegate {
            delegate.showCompleted(self)
        }
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
