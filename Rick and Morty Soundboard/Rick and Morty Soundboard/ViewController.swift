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
  
  var settings: [String: AnyObject] = [:]
  
  var audioPlayer: AVAudioPlayer!
  var tracks: [Track] = []
  
  var currentTrack: Track?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    importSettings()
    importTrackData()
    collectionView.reloadData()
    
    setupSampleSound()
    
  }
  
  // MARK: Audio player
  
  func setupSampleSound() {
    if let sampleSound = NSDataAsset(name: "tiny rick") {
      do {
        try audioPlayer = AVAudioPlayer(data: sampleSound.data)
        audioPlayer.prepareToPlay()
        
      } catch {
        print("Error playing sample sound: \(sampleSound)")
        
      }
    }
  }
  
  func playSound(audioFileName: String) {
    if audioPlayer.isPlaying {
      stopSound()
    }
    
    if let sound = NSDataAsset(name: audioFileName) {
      do {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try audioPlayer = AVAudioPlayer(data: sound.data)
        // audioPlayer.delegate = self
        audioPlayer.play()
        
      } catch {
        print("Error playing sound: \(audioFileName)")
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
    
    // Play sound
    let track = tracks[indexPath.row]
    playSound(audioFileName: track.soundFileName)
    
    track.beingPlayed = true
    UIView.animate(withDuration: 2, animations: {
      self.collectionView.reloadData()
    })
    
    currentTrack = track
    
    Timer.scheduledTimer(withTimeInterval: audioPlayer.duration, repeats: false, block: {_ in
      track.beingPlayed = false
      self.collectionView.reloadData()
      
    })
    
  }
  
  func stopSound() {
    print("Finished playing")
    currentTrack?.beingPlayed = false
    
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
  
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  //    let picDimension = self.view.frame.size.width / 4.0
  //    return CGSize(width: picDimension, height: picDimension)
  //
  //  }
  //
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
  //    let leftRightInset = self.view.frame.size.width / 14.0
  //    return UIEdgeInsets(top: 0, left: leftRightInset, bottom: 0, right: leftRightInset)
  //
  //  }
  
  // MARK: Importing data
  
  func importSettings() {
    settings = [
      "wallpaper": "eating title" as AnyObject,
      "theme": "default" as AnyObject,
      "glassEffect": true as AnyObject,
      "longPressLoops": true as AnyObject,
      "simultaneousPlayback": false as AnyObject,
      "isDeveloper": true as AnyObject
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

