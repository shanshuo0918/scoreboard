//
//  LogTableViewCell.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/9/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    

    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var logLabel: UILabel!
    
    @IBOutlet var gameScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
