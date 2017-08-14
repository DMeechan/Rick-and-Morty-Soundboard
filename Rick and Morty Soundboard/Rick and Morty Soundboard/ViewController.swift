//
//  ViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate {
  
  // @IBOutlet weak var collectionView: UICollectionView!
  
  var collectionView: UICollectionView?
  let trackCellIdentifier: String = "trackCell"
  
  var settings: [String: AnyObject] = [:]
  
  var audioPlayer: AVAudioPlayer!
  var tracks: [Track] = []
  
  var currentTrackName: String = ""
  
  var movingIndexPath: IndexPath?
  
  // MARK: User interface
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    importSettings()
    importTrackData()
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressReceived(_:)))
     collectionView?.addGestureRecognizer(longPress)
    longPress.minimumPressDuration = 0.3
    
    // setupSampleSound()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    collectionView?.reloadData()
  }
  
  // MARK: Moving cells
  
  func longPressed(_ gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)
    movingIndexPath = collectionView?.indexPathForItem(at: location)
    
    if gesture.state == .began {
      guard let indexPath = movingIndexPath else { return }
      
      setEditing(true, animated: true)
      collectionView?.beginInteractiveMovementForItem(at: indexPath)
      animatePickingUpCell(cell: pickedUpCell())
    } else if(gesture.state == .changed) {
      collectionView?.updateInteractiveMovementTargetPosition(location)
    } else {
      gesture.state == .ended
        ? collectionView?.endInteractiveMovement()
        : collectionView?.cancelInteractiveMovement()
      
      animatePuttingDownCell(cell: pickedUpCell())
      movingIndexPath = nil
    }
  }
  
  func longPressReceived(_ gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)
    movingIndexPath = collectionView?.indexPathForItem(at: location)
    
    switch (gesture.state) {
      
    case UIGestureRecognizerState.began:
      guard let indexPath = movingIndexPath else { return }
      setEditing(true, animated: true)
      collectionView?.beginInteractiveMovementForItem(at: indexPath)
      animatePickingUpCell(cell: pickedUpCell())
      
    case UIGestureRecognizerState.changed:
      collectionView?.updateInteractiveMovementTargetPosition(location)
      
    case UIGestureRecognizerState.ended:
      collectionView?.endInteractiveMovement()
      animatePuttingDownCell(cell: pickedUpCell())
      movingIndexPath = nil
      
    default:
      collectionView?.cancelInteractiveMovement()
      animatePuttingDownCell(cell: pickedUpCell())
      movingIndexPath = nil
      
    }
    
  }
  
  func pickedUpCell() -> TrackCollectionViewCell? {
    guard let indexPath = movingIndexPath else { return nil }
    
    return collectionView?.cellForItem(at: indexPath) as? TrackCollectionViewCell
    
  }
  
  func animatePickingUpCell(cell: TrackCollectionViewCell?) {
    UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { () -> Void in
      cell?.alpha = 0.7
      cell?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }, completion: { finished in
      
    })
  }
  
  func animatePuttingDownCell(cell: TrackCollectionViewCell?) {
    UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { () -> Void in
      cell?.alpha = 1.0
      cell?.transform = CGAffineTransform.identity
    }, completion: { finished in
      
    })
    
    collectionView?.reloadData()
    
  }
  
  
  // MARK: Collection View
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let track = tracks.remove(at: sourceIndexPath.item)
    tracks.insert(track, at: destinationIndexPath.item)
    
  }
  
  func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    collectionView?.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: trackCellIdentifier)
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = UIColor.red
    
    self.view.addSubview(collectionView!)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Give cells their contents
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackCellIdentifier, for: indexPath) as! TrackCollectionViewCell
    
    let track = tracks[indexPath.row]
    
    cell.setTrack(track: track)
    
    // Check if the cell is being played currently
    if track.name == currentTrackName {
      // Track is being played
      cell.showPlayOverlay(trackImage: track.image)
      
    } else {
      cell.removeOverlay()
      
    }
    
    // Link cell with track
    // cell.setTrack(item: track, beingPlayed: beingPlayed)
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Take action when a cell is clicked
    print("Clicked cell at: \(indexPath.row)")
    
    // Play sound
    let track = tracks[indexPath.row]
    playSound(audioFileName: track.soundFileName)
    
    currentTrackName = track.name
    
    collectionView.reloadData()
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Return number of cells in collection
    return tracks.count
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    // Return number of sections in collection
    return 1
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 80, height: 120)
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
  
  // MARK: Audio player
  
  func playSound(audioFileName: String) {
    if let sound = NSDataAsset(name: audioFileName) {
      do {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try audioPlayer = AVAudioPlayer(data: sound.data)
        audioPlayer.play()
        
        audioPlayer.delegate = self
        
      } catch {
        print("Error playing sound: \(audioFileName)")
      }
    }
    
  }
  
  func setupSampleSound() {
    if let sampleSound = NSDataAsset(name: "tiny rick_sound") {
      do {
        try audioPlayer = AVAudioPlayer(data: sampleSound.data)
        audioPlayer.prepareToPlay()
        
      } catch {
        print("Error playing sample sound: \(sampleSound)")
        
      }
    }
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    print("Running delegate")
    currentTrackName = ""
    collectionView?.reloadData()
  }
  
  // MARK: Importing data
  
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
  
  func importTrackData() {
    var items = [Track]()
    
    let inputFile = Bundle.main.path(forResource: "trackData", ofType: "plist")
    
    let inputDataArray = NSArray(contentsOfFile: inputFile!)
    
    for item in inputDataArray as! [Dictionary<String, String>] {
      let track = Track(dataDictionary: item)
      
      if trackNotUnique(track: track) {
        track.name += "2"
      }
      
      items.append(track)
      
    }
    
    tracks = items
    
  }
  
  func trackNotUnique(track: Track) -> Bool {
    for existingTrack in tracks {
      if track.name == existingTrack.name {
        print("Track \(track.name) has a duplicate! Attempting to correct.")
        return true
        
      }
    }
    return false
    
  }
  
  
}

