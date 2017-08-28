//
//  ViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class TracksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate {
  
  // User interface
  
  var collectionView: UICollectionView?
  let trackCellIdentifier: String = "trackCell"
  
  var audioPlayer: AVAudioPlayer!
  
  var currentTrackName: String = ""
  
  var movingIndexPath: IndexPath?
  
  // Admob
  var bannerView: GADBannerView!
  let bannerViewAdID = "ca-app-pub-4605466962808569/8213398455"
  
  // MARK: User interface
  
  // These two functions prevent the nav bar appearing at the top on this page, but still appearing in Settings
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("Reloading view")
    
    // Start tracking long presses on track buttons to move them about
    guard let enableFavourites: Bool = Datas.shared.settings["enableFavourites"] as? Bool else { return }
    if enableFavourites {
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressReceived(_:)))
      collectionView?.addGestureRecognizer(longPress)
      longPress.minimumPressDuration = 0.3
      
    }
    
    // setupSampleSound()
    
  }
  
  func loadBannerAd() {
    let request = GADRequest()
    request.testDevices = [ kGADSimulatorID, "a97f268c2e35184ca641fac156d63884" ]
    
    bannerView.load(request)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("View has appeared!")
    
    setupViews()
    //collectionView?.reloadData()
    
    // settingsButtonClicked()
  }
  
  func getWallpaper() -> UIImageView? {
    
    let wallpaperFilename = Datas.shared.getWallpaperFilename()
    
    if wallpaperFilename == "None_wallpaper" {
      self.view.backgroundColor = UIColor.clear
      return nil
      
    } else {
      // Set wallpaper
      let wallpaper: UIImageView = UIImageView(image: UIImage(named: wallpaperFilename))
      
      // Set blue
      guard let blur: Bool = Datas.shared.settings["wallpaperBlur"] as? Bool else { return nil }
      print("Wallpaper blur is: ", blur)
      
      if blur {
        wallpaper.blurImage(id: wallpaperFilename, blurValue: 5)
      }
      
      wallpaper.backgroundColor = UIColor.flatBlack().withAlphaComponent(0.5)
      
      return wallpaper
      
    }
    
  }
  
  
  func setupViews() {
    setupCollectionView()
    
    var wallpaperImageView = UIImageView()
    
    if let wallpaper: UIImageView = getWallpaper(){
      wallpaperImageView = wallpaper
      
    } else {
      print("Wallpaper = None // or // unable to get wallpaper ")
      
    }
    
    // Not creating favImageView yet until have checked if it's enabled
    var favImageView = UIImageView()
    var favImageViewWidth: Double = 0
    
    guard let enableFavourites: Bool = Datas.shared.settings["enableFavourites"] as? Bool else { return }
    
    if enableFavourites {
      favImageViewWidth = 100
      
      favImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.flatOrange()
        imageView.alpha = 0.5
        return imageView
        
      }()
    }
    
    bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
    //kGADAdSizeBanner
    
    let settingsButon: UIButton = {
      let button = UIButton()
      button.contentMode = .scaleToFill
      button.setImage(UIImage(named: "settings_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
      button.tintColor = Style.settingsIconColor
      button.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
      return button
      
    }()
    
    self.view.addSubview(wallpaperImageView)
    self.view.addSubview(collectionView!)
    self.view.addSubview(bannerView)
    self.view.addSubview(settingsButon)
    self.view.addSubview(favImageView)
    
    bannerView.adUnitID = bannerViewAdID
    bannerView.rootViewController = self
    
    wallpaperImageView.translatesAutoresizingMaskIntoConstraints = false
    collectionView?.translatesAutoresizingMaskIntoConstraints = false
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    settingsButon.translatesAutoresizingMaskIntoConstraints = false
    favImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let items = [
      "wallpaper": wallpaperImageView,
      "collection": collectionView!,
      "bannerView": bannerView,
      //      "banner": bannerImageView,
      "settings": settingsButon,
      "favourites": favImageView
      ] as [String : Any]
    
    addConstraint(visualFormat: "V:|-25-[settings(40)]-10-[collection][favourites(\(favImageViewWidth))]-10-[bannerView(50)]-5-|", items: items)
    addConstraint(visualFormat: "V:|[wallpaper]|", items: items)
    
    addConstraint(visualFormat: "H:|[wallpaper]|", items: items)
    addConstraint(visualFormat: "H:[settings(40)]-5-|", items: items)
    addConstraint(visualFormat: "H:|[collection]|", items: items)
    addConstraint(visualFormat: "H:|[favourites]|", items: items)
    addConstraint(visualFormat: "H:|[bannerView]|", items: items)
    
    
  }
  
  func addConstraint(visualFormat: String, items: [String: Any]) {
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutFormatOptions(), metrics: nil, views: items))
    
  }
  
  func settingsButtonClicked() {
    //  (sender: UIButton!)
    
    self.navigationController?.pushViewController(SettingsFormViewController(), animated: true)
    
  }
  
  // MARK: Moving cells
  
  func longPressReceived(_ gesture: UILongPressGestureRecognizer) {
    let location = gesture.location(in: collectionView)
    movingIndexPath = collectionView?.indexPathForItem(at: location)
    
    switch (gesture.state) {
      
    case UIGestureRecognizerState.began:
      guard let indexPath = movingIndexPath else { return }
      // setEditing(true, animated: true)
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
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: true)
    
  }
  
  
  // MARK: Collection View
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let track = DataManager.shared.tracks.remove(at: sourceIndexPath.item)
    DataManager.shared.tracks.insert(track, at: destinationIndexPath.item)
    
  }
  
  func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    
    // self.view.bounds
    collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
    collectionView?.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: trackCellIdentifier)
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = UIColor.clear
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Give cells their contents
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackCellIdentifier, for: indexPath) as! TrackCollectionViewCell
    
    let track = DataManager.shared.tracks[indexPath.row]
    
    cell.setTrack(track: track)
    
    // Check if the cell is being played currently
    if track.sound == currentTrackName {
      // Track is being played
      cell.showPlayOverlay(trackImage: (track.character))
      
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
    let track = DataManager.shared.tracks[indexPath.row]
    print("Trying to play sound: ", track.sound)
    playSound(audioFileName: (track.sound + "_sound"))
    
    currentTrackName = track.sound
    
    collectionView.reloadData()
    
//    let trackNameWithoutSpaces = track.sound.components(separatedBy: " ").filter({ !$0.isEmpty } ).joined(separator: "_")
//    let trackNameWithoutCommas = trackNameWithoutSpaces.components(separatedBy: ",").filter({ !$0.isEmpty } ).joined(separator: "_")
//    let trackNameWithoutApostrophes = trackNameWithoutCommas.components(separatedBy: "'").filter({ !$0.isEmpty } ).joined(separator: "_")
//    
//    let trackNameUnderscored = trackNameWithoutApostrophes
    
    // Replace whitespace with _
    let trackWithoutSpaces = track.sound.replacingOccurrences(of: "\\s", with: "_", options: .regularExpression, range: nil)
    
    // Remove non-alphanumerics
    let trackWithoutPunctuation = trackWithoutSpaces.replacingOccurrences(of: "\\W", with: "", options: .regularExpression, range: nil)
    
    let trackNameUnderscored = trackWithoutPunctuation
    
    
    Datas.logEvent(eventName: "Clicked_\(trackNameUnderscored)")
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Return number of cells in collection
    return DataManager.shared.tracks.count
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    // Return number of sections in collection
    return 1
    
  }
  
  // MARK: Dynamically update cell sizes
  // TODO: One of these two functions is preventing the nameLabel from appearing
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // let picDimension = self.view.frame.size.width / 4.0
    // return CGSize(width: picDimension, height: picDimension)
    
    return CGSize(width: 80, height: 120)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let leftRightInset = self.view.frame.size.width / 14.0
    return UIEdgeInsets(top: 0, left: leftRightInset, bottom: 0, right: leftRightInset)
    
  }
  
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
  
  
}

