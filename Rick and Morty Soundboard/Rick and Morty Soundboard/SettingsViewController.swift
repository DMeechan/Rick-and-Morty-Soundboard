//
//  SettingsViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 14/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
  
  //// Sections:
  // Design
  // Playback
  // About
  ////
  
  var wallpaperCell: UITableViewCell = UITableViewCell()
  var darkThemeCell: UITableViewCell = UITableViewCell()
  var blurredWallpaperCell: UITableViewCell = UITableViewCell()
  var blurredTrackCell: UITableViewCell = UITableViewCell()
  var simultaneousPlaybackCell: UITableViewCell = UITableViewCell()
  var isDeveloperCell: UITableViewCell = UITableViewCell()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func detectGestures() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    self.view.addGestureRecognizer(swipeLeft)
    
  }
  
  func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
      switch swipeGesture.direction {
      case UISwipeGestureRecognizerDirection.left:
        print("Swiped left")
        closeView()
      default:
        break
      }
    }
  }
  
  override func loadView() {
    super.loadView()
    
    // Setting up cells
    wallpaperCell = createBoolTableViewCell(name: "Show wallpaper", id: "wallpaper")
    darkThemeCell = createBoolTableViewCell(name: "Use dark theme", id: "darkTheme")
    blurredWallpaperCell = createBoolTableViewCell(name: "Add blur to wallpaper", id: "glassEffectOnWallpaper")
    blurredTrackCell = createBoolTableViewCell(name: "Add blur to button images when clicked", id: "glassEffectOnTracks")
    simultaneousPlaybackCell = createBoolTableViewCell(name: "Play multiple sounds simultaneously", id: "simultaneousPlayback")
    isDeveloperCell = createBoolTableViewCell(name: "Developer", id: "isDeveloper")
    
    updateWallpaper()
    updateDarkTheme()
    
  }
  
  func closeView() {
     dismiss(animated: true, completion: nil)
    
//    let viewController = ViewController()
//    self.present(viewController, animated: true, completion: nil)
    
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header = view as! UITableViewHeaderFooterView
    
    // header.contentView.backgroundColor = Style.settingsHeaderBackgroundColor
    // header.textLabel?.textColor = Style.settingsHeaderTextColor
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Give cells their contents by evaluating their section number and row number
    
    var cell = UITableViewCell()
    
    switch(indexPath.section) {
    
    case 0:
      switch(indexPath.row) {
      case 0: cell = self.wallpaperCell
      case 1: cell =  self.darkThemeCell
      case 2: cell =  self.blurredWallpaperCell
      case 3: cell =  self.blurredTrackCell
      default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    case 1:
      switch(indexPath.row) {
      case 0: cell =  self.simultaneousPlaybackCell
        default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    case 2:
      switch(indexPath.row) {
      case 0: cell =  self.isDeveloperCell
      default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    default:
      fatalError("Unknown section: \(indexPath.section)")
    }
    
    updateCellStyling(cell: cell)
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // Set header titles
    switch(section) {
    case 0: return "Design"
    case 1: return "Playback"
    case 2: return "About"
    default: fatalError("Unknown section: \(section)")
      
    }
    
  }
  
  func updateCellStyling(cell: UITableViewCell) {
    cell.textLabel?.font = Style.settingsFont
    
    cell.backgroundColor = Style.settingsCellBackgroundColor
    cell.textLabel?.textColor = Style.settingsCellTextColor
    
    // Update colour of tick
    cell.tintColor = Style.settingsCellTextColor
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return number of rows in a section
    switch (section) {
    case 0: return 4 // section 0 has 4 rows
    case 1: return 1 // section 1 has 1 row
    case 2: return 1 // section 2 has 1 row
    default:  // error; unknown section
      print("FATAL ERROR: Unknown section number given: \(section)")
      return 0
      
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // Return number of sections
    return 3
    
  }
  
  func createBoolTableViewCell(name: String, id: String) -> UITableViewCell {
    let cell: UITableViewCell = {
      let cell = UITableViewCell()
      cell.textLabel?.text = name

      updateCellStyling(cell: cell)
      
      if Datas.shared.getBoolFromSetting(id: id) {
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        
      } else {
        cell.accessoryType = UITableViewCellAccessoryType.none
        
      }
      
      // Changes the alpha of the *contents* of the cell (in this case... the text)
      // cell.contentView.alpha = 0.5
      
      return cell
      
    }()
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Take action when user clicks on cell
    
    switch(indexPath.section) {
      
    case 0:
      switch(indexPath.row) {
      case 0: handleBoolCellClick(id: "wallpaper", cell: self.wallpaperCell, indexPath: indexPath)
      case 1: handleBoolCellClick(id: "darkTheme", cell: self.darkThemeCell, indexPath: indexPath)
      case 2: handleBoolCellClick(id: "glassEffectOnWallpaper", cell: self.blurredWallpaperCell, indexPath: indexPath)
      case 3: handleBoolCellClick(id: "glassEffectOnTracks", cell: self.blurredTrackCell, indexPath: indexPath)
      default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    case 1:
      switch(indexPath.row) {
      case 0: handleBoolCellClick(id: "simultaneousPlayback", cell: self.simultaneousPlaybackCell, indexPath: indexPath)
        closeView()
      default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    case 2:
      switch(indexPath.row) {
      case 0: handleBoolCellClick(id: "isDeveloper", cell: self.isDeveloperCell, indexPath: indexPath)
      default: fatalError("Unknown row: \(indexPath.row) in section \(indexPath.section)")
      }
      
    default:
      fatalError("Unknown section: \(indexPath.section)")
    }
    
  }
  
  func handleBoolCellClick(id: String, cell: UITableViewCell, indexPath: IndexPath) {
    inverseBoolSetting(id: id, indexPath: indexPath)
    showBoolSetting(id: id, cell: cell)
    
    // Only need to run methods for settings which affect the SettingsView
    switch(id) {
      case "wallpaper": updateWallpaper()
      case "darkTheme": updateDarkTheme()
      case "glassEffectOnWallpaper": updateWallpaper()
    default: break;
    }
    
  }
  
  func updateWallpaper() {
    if Datas.shared.getBoolFromSetting(id: "wallpaper") {
      
      let blur: Bool = Datas.shared.getBoolFromSetting(id: "glassEffectOnWallpaper")
      setWallpaper(blur: blur)
      // tableView.backgroundColor = Style.wallpaperTintColor
      
    } else {
      tableView.backgroundView = nil
      tableView.backgroundColor = Style.wallpaperColor
      
    }
    
    // Prevent text being lost with the wallpaper by adding a light overlay
    // tableView.backgroundView?.alpha = 0.9
    // tableView.backgroundColor = Style.wallpaperTintColor
    
  }
  
  func updateDarkTheme() {
    if Datas.shared.getBoolFromSetting(id: "darkTheme") {
      // Use dark theme
//      Style.setThemeDark()
      
    } else {
      // Use light theme
//      Style.setThemeLight()
      
    }
    
    tableView.reloadData()
    updateWallpaper()
    
  }
  
  func setWallpaper(blur: Bool) {
    // Adding background wallpaper
    
    // let wallpaperImage: String = "eating title_wallpaper"
    let wallpaperImage: String = "jail rick_wallpaper"
    
    let wallpaper: UIImageView = UIImageView(image: UIImage(named: wallpaperImage))
    
    if blur {
      wallpaper.blurImage(id: wallpaperImage, blurValue: 5)
    }
    
    tableView.backgroundView = wallpaper
    
  }
  
  
  func inverseBoolSetting(id: String, indexPath: IndexPath) {
    // Deselect cell
    tableView.deselectRow(at: indexPath, animated: true)
    
    // Update value in settings

    let inverseValue = !(Datas.shared.getBoolFromSetting(id: id))
    
    Datas.shared.settings.updateValue(String(inverseValue), forKey: id)
    
  }
  
  func showBoolSetting(id: String, cell: UITableViewCell) {
    let value = Datas.shared.getBoolFromSetting(id: id)
    
    if value == true {
      cell.accessoryType = UITableViewCellAccessoryType.checkmark
      
    } else {
      cell.accessoryType = UITableViewCellAccessoryType.none
      
    }
    
    print("Value for: \(id) is now: \(value)")
    
  }
  
  
}
