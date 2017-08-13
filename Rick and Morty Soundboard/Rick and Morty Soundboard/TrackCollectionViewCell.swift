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
    let symbolImageView = UIImageView(image: UIImage(named: "play"))
    symbolImageView.frame = charImageView.bounds
    charImageView.addSubview(symbolImageView)
    
    view.addSubview(charImageView)
    
    // useStoryboard(item: item)
    
  }
  
  func playTrack() {
    showSymbol(symbolImageName: "play")
    showBlur()
    showBorder()
    
  }
  
  func stopTrack() {
    hideSymbol()
    hideBlur()
    hideBorder()
    
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
  
  func showBlur() {
    
    blurredEffectView.isHidden = false
    
  }
  
  func hideBlur() {
    blurredEffectView.isHidden = true
  }
  
  func showBorder() {
    charImageView.layer.borderWidth = 3
  }
  
  func hideBorder() {
    charImageView.layer.borderWidth = 0
  }
  
  func showSymbol(symbolImageName: String) {
    symbolImage.image = UIImage(named: symbolImageName)
    
  }
  
  func hideSymbol() {
    symbolImage.image = nil
  }
  
}
