//
//  MenuViewController.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/24/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var score1: UILabel!
    
    @IBOutlet var score2: UILabel!
    
    @IBOutlet var scorebig: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        button1.layer.cornerRadius = 20
        button2.layer.cornerRadius = 20
        score1.layer.cornerRadius = 10
        //score1.layer.borderColor = UIColor.blackColor().CGColor
        score1.layer.backgroundColor = UIColor.whiteColor().CGColor
        //score1.layer.borderWidth = 2
        
        score2.layer.cornerRadius = 10
        //score2.layer.borderColor = UIColor.blackColor().CGColor
        score2.layer.backgroundColor = UIColor.whiteColor().CGColor
        //score2.layer.borderWidth = 2
        scorebig.layer.cornerRadius = 10
        scorebig.layer.borderColor = UIColor.whiteColor().CGColor
        scorebig.layer.borderWidth = 2
        
        
        //button1.hidden = true
        //button2.hidden = true
        //scorebig.layer.backgroundColor = UIColor.blackColor().CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
