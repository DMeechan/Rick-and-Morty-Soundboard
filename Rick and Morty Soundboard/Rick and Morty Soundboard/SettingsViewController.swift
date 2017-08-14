//
//  SettingsViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 14/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  

  
  var settings: [String: AnyObject] = [:]
  
  //// Sectins:
  // Playback
  // Design
  // About
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Give cells their contents
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! TrackCollectionViewCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
   return 1
  }
  
  func importSettings() {
    settings = [
      "wallpaper": "eating title" as AnyObject,
      "theme": "default" as AnyObject,
      "glassEffectOnWallpaper": true as AnyObject,
      "glassEffectOnTracks": true as AnyObject,
      "longPressLoops": true as AnyObject,
      "simultaneousPlayback": false as AnyObject,
      "isDeveloper": true as AnyObject
    ]
    
  }
  
}
