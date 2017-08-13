//
//  TrackCollectionViewCell.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func setTrack(item: Track) {
        trackButton.setImage(UIImage(named: item.image), for: .normal)
        
        trackButton.imageView?.layer.cornerRadius = ((trackButton.imageView?.frame.size.width)! / 2)
        trackButton.imageView?.clipsToBounds = true
        
        trackButton.imageView?.layer.borderWidth = 2
        trackButton.imageView?.layer.borderColor = UIColor.red.cgColor
        
        trackNameLabel.text = item.name
        
        
    }
    
}
