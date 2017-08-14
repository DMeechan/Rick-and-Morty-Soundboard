//
//  TrackCollectionViewCell.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import CoreImage

class TrackCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setTrack(track: Track())
    
  }
  
  // Create character image
  let charImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.green
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    
    imageView.layer.borderColor = UIColor.clear.cgColor
    imageView.layer.borderWidth = 3
    
    return imageView
    
  }()
  
  // Create text field for track name
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello world"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightUltraLight)
    label.numberOfLines = 3
    label.lineBreakMode = .byTruncatingTail
    // label.lineBreakMode = .byCharWrapping
    label.clipsToBounds = true
    
    return label
    
  }()
  
  func setupViews() {
    addSubview(charImageView)
    addSubview(nameLabel)
    
    charImageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    setupConstraints()
    
  }
  
  func setupConstraints() {
    let items = [
      "label": nameLabel,
      "image": charImageView
    ]
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(80)][label(40)]|", options: NSLayoutFormatOptions(), metrics: nil, views: items))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: NSLayoutFormatOptions(), metrics: nil, views: items))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(80@500)]|", options: NSLayoutFormatOptions(), metrics: nil, views: items))
    
  }
  
  func setTrack(track: Track) {
    nameLabel.text = track.name
    charImageView.image = UIImage(named: track.image)
    
    // Create circular mask
    
    charImageView.layer.cornerRadius = charImageView.bounds.size.width / 2.0

  }
  
  func showPlayOverlay(trackImage: String) {
    // Create image border
    charImageView.layer.borderColor = UIColor.white.cgColor
    
    // Create blur effect
    //charImageView.blur(blurRadius: CGFloat(1.1))
    //charImageView.image?.ciImage?.applyingGaussianBlur(withSigma: 200.0)
    
    charImageView.blurImage(id: trackImage)
    
    // Old method to create blur effect
    let blurEffect = UIBlurEffect(style: .light)
    let blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView.frame = charImageView.bounds
    // charImageView.addSubview(blurredEffectView)
    
    // Create icon image
    let iconImageView = UIImageView()
    iconImageView.image = UIImage(named: "play_icon")
    iconImageView.frame = charImageView.bounds
    charImageView.addSubview(iconImageView)
    
  }
  
  func removeOverlay() {
    // Hide image border
    charImageView.layer.borderColor = UIColor.clear.cgColor
//    charImageView.unBlur()
    
    for subview in charImageView.subviews {
      subview.removeFromSuperview()
    }
    
  }
  
  func setTrack(item: Track, beingPlayed: Bool) {
    print("ERROR: RUNNING WRONG FUNCTION")
    // Create character image
    let charImageView = UIImageView(image: UIImage(named: item.image))
    charImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    charImageView.contentMode = .scaleToFill
    
    // Create circular mask
    charImageView.layer.cornerRadius = (charImageView.frame.size.width / 2)
    charImageView.clipsToBounds = true
    
    // Create text field for track name
    let nameLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightUltraLight)
      return label
      
    }()
    
    nameLabel.text = item.name
    
    // Create overlays if being played
    print("Being played: \(beingPlayed)")
    if beingPlayed {
      // Create border
      charImageView.layer.borderColor = UIColor.white.cgColor
      charImageView.layer.borderWidth = 3
      
      // Create blur effect
      let blurEffect = UIBlurEffect(style: .light)
      let blurredEffectView = UIVisualEffectView(effect: blurEffect)
      blurredEffectView.frame = charImageView.bounds
      charImageView.addSubview(blurredEffectView)
      
      // Create icon image
      let iconImageView = UIImageView()
      iconImageView.image = UIImage(named: "play_icon")
      iconImageView.frame = charImageView.bounds
      charImageView.addSubview(iconImageView)
      
    }
    
    addSubview(charImageView)
    addSubview(nameLabel)
    // setupConstraints(label: nameLabel, charImageView: charImageView)
    
  }
  
  func labelConstraints(label: UILabel) {
    
    // Leading constraint; right side
    let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
    
    // trailing constraint; right side
    let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    // Bottom
    let bottom = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    
    // Height
    let height = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)
    
    let constraints: [NSLayoutConstraint] = [
      leading, trailing, bottom, height
    ]
    
    self.addConstraints(constraints)
    NSLayoutConstraint.activate(constraints)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
