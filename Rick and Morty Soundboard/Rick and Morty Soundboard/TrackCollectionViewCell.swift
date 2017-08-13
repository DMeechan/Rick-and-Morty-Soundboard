//
//  TrackCollectionViewCell.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var trackImage: UIImageView!
  @IBOutlet weak var iconImage: UIImageView!
  
  @IBOutlet weak var view: UIView!
  
  var charImageView: UIImageView = UIImageView()
  var blurredEffectView: UIVisualEffectView = UIVisualEffectView()
  var iconImageView = UIImageView()
  
  let animationDuration: Double = 0.4
  
  func setTrack(item: Track, beingPlayed: Bool) {
    // Create character image
    charImageView = UIImageView(image: UIImage(named: item.image))
    charImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    charImageView.contentMode = .scaleToFill
    
    // Create circular mask
    charImageView.layer.cornerRadius = (charImageView.frame.size.width / 2)
    charImageView.clipsToBounds = true
    
    print("Being played: \(beingPlayed)")
    
    if beingPlayed {
      // Create border
      charImageView.layer.borderColor = UIColor.white.cgColor
      charImageView.layer.borderWidth = 3
      
      // Create blur effect
      let blurEffect = UIBlurEffect(style: .light)
      blurredEffectView = UIVisualEffectView(effect: blurEffect)
      blurredEffectView.frame = charImageView.bounds
      charImageView.addSubview(blurredEffectView)
      
      // Create icon image
      showIcon(iconImageName: "play")
      iconImageView.frame = charImageView.bounds
      charImageView.addSubview(iconImageView)
      
    }
    
    view.addSubview(charImageView)
    
  }
  
  func showIcon(iconImageName: String) {
    var iconName = iconImageName
    iconName.append("_icon")
    
    iconImageView.image = UIImage(named: iconName)
    
  }
  
  func hideIcon() {
    iconImageView.image = nil
  }
  
  func useStoryboard(item: Track) {
    // Set name label
    trackNameLabel.text = item.name
    
    
    // Set background image
    // trackButton.setImage(UIImage(named: item.image), for: .normal)
    trackImage.image = UIImage(named: item.image)
    trackImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    
    // Create circular mask
    trackImage.layer.cornerRadius = (trackImage.frame.size.width / 2)
    trackImage.clipsToBounds = true
    
    // Add border
    trackImage.layer.borderWidth = 3
    trackImage.layer.borderColor = UIColor.white.cgColor
    
    // Set up icon image
    iconImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    iconImage.image = UIImage(named: "play_icon")
    trackImage.addSubview(iconImage)
    
  }
  
}
