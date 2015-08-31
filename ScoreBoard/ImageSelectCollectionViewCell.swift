//
//  ImageSelectCollectionViewCell.swift
//  ScoreBoard
//
//  Created by SHUO SHAN on 8/25/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageSelectCollectionViewCell: UICollectionViewCell {
    var imageData: NSData? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    
    func updateUI() {
        imageView.image = UIImage(data: imageData!)
    }
    
}
