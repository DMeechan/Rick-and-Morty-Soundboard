//
//  ViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var tracks: [Track] = []
  var audioPlayer: AVAudioPlayer!
  
  var settings: [String: AnyObject] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    importSettings()
    importTrackData()
    collectionView.reloadData()
    
    audioPlayer = AVAudioPlayer()
    
  }
  
  // MARK: Audio player
  

  func playSound(audioFileNameInAssets: String) {
    if let sound = NSDataAsset(name: audioFileNameInAssets) {
      do {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        try audioPlayer = AVAudioPlayer(data: sound.data)
        audioPlayer.play()
        
      } catch {
        print("Error playing sound: \(audioFileNameInAssets)")
      }
    }
    
  }
  
  // MARK: Collection View
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Give cells their contents
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as! TrackCollectionViewCell
    
    cell.setTrack(item: tracks[indexPath.row])
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Take action when a cell is selected
    print("Clicked cell at: \(indexPath.row)")
    
    let track = tracks[indexPath.row]
    
    playSound(audioFileNameInAssets: track.soundFileName)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Return number of cells in collection
    return tracks.count
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    // Return number of sections in collection
    return 1
    
  }
  
  // MARK: Dynamically update cell sizes
  // TODO: One of these two functions is preventing the nameLabel from appearing
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let picDimension = self.view.frame.size.width / 4.0
    return CGSize(width: picDimension, height: picDimension)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let leftRightInset = self.view.frame.size.width / 14.0
    return UIEdgeInsets(top: 0, left: leftRightInset, bottom: 0, right: leftRightInset)
    
  }
  
  // MARK: Importing data
  
  func importSettings() {
    settings = [
      "wallpaper": "eating title" as AnyObject,
      "theme": "default" as AnyObject,
      "glassEffect": true as AnyObject,
      "wallpaper": true as AnyObject,
      "longPressLoops": true as AnyObject,
      "simultaneousPlayback": false as AnyObject
    ]
    
  }
  
  func importTrackData() {
    var items = [Track]()
    
    let inputFile = Bundle.main.path(forResource: "trackData", ofType: "plist")
    
    let inputDataArray = NSArray(contentsOfFile: inputFile!)
    
    for item in inputDataArray as! [Dictionary<String, String>] {
      let track = Track(dataDictionary: item)
      items.append(track)
      
    }
    
    tracks = items
    
  }
  
  
}

