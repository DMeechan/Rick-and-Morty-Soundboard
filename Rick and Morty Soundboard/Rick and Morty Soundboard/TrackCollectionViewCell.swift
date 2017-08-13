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
  @IBOutlet weak var symbolImage: UIImageView!
  
  @IBOutlet weak var view: UIView!
  
  var charImageView: UIImageView = UIImageView()
  var blurredEffectView: UIVisualEffectView = UIVisualEffectView()
  var symbolImageView = UIImageView()
  
  let animationDuration: Double = 0.4
  
  func setTrack(item: Track) {
    // Create character image
    charImageView = UIImageView(image: UIImage(named: item.image))
    charImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    charImageView.contentMode = .scaleToFill
    
    // Create circular mask
    charImageView.layer.cornerRadius = (charImageView.frame.size.width / 2)
    charImageView.clipsToBounds = true
    
    // Create border
    charImageView.layer.borderColor = UIColor.white.cgColor
    
    // Create blur effect
    let blurEffect = UIBlurEffect(style: .light)
    blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView.frame = charImageView.bounds
    charImageView.addSubview(blurredEffectView)
    
    // Create symbol image
    symbolImageView.frame = charImageView.bounds
    charImageView.addSubview(symbolImageView)
    
    print("Being played is: \(item.beingPlayed)")
    if item.beingPlayed {
      showOverlay()
      
    } else {
      hideOverlay()
      
    }
    
    view.addSubview(charImageView)
    
    // useStoryboard(item: item)
    
  }
  
  func showOverlay() {
    self.showSymbol(symbolImageName: "play")
    self.charImageView.layer.borderWidth = 3
    self.blurredEffectView.isHidden = false
    
  }
  
  func hideOverlay() {
    self.hideSymbol()
    self.charImageView.layer.borderWidth = 0
    self.blurredEffectView.isHidden = true

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
    
    // Set up symbol image
    symbolImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    symbolImage.image = UIImage(named: "play")
    trackImage.addSubview(symbolImage)
    
  }
  
  func showSymbol(symbolImageName: String) {
    symbolImageView.image = UIImage(named: symbolImageName)
    
  }
  
  func hideSymbol() {
    symbolImageView.image = nil
  }
  
}
