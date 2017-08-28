//
//  SettingsFormViewController.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 15/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Eureka

class SettingsFormViewController: FormViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // view.backgroundColor = UIColor.flatPink()
    // tableView.backgroundColor = UIColor.clear
    
    navigationItem.title = "Settings"
    
    // Set up styling
    updateRows()
    
    // Set up user interface
    setupForm()
    
    updateWallpaper()
    
  }
  
  func updateRows() {
    
    CheckRow.defaultCellUpdate = { cell, row in
      cell.textLabel?.textColor = Style.settingsCellTextColor
      cell.tintColor = Style.settingsCellTextColor
      
      cell.backgroundColor = Style.settingsCellBackgroundColor
      
    }
    
    LabelRow.defaultCellUpdate = { cell, row in
      cell.textLabel?.textColor = Style.settingsCellTextColor
      cell.detailTextLabel?.textColor = Style.settingsCellTextColor
      cell.tintColor = Style.settingsCellTextColor
      
      cell.backgroundColor = Style.settingsCellBackgroundColor
      
    }
    
    ActionSheetRow<String>.defaultCellUpdate = { cell, row in
      cell.textLabel?.textColor = Style.settingsCellTextColor
      cell.detailTextLabel?.textColor = Style.settingsCellTextColor
      cell.tintColor = Style.settingsCellTextColor
      
      cell.backgroundColor = Style.settingsCellBackgroundColor
      
    }
    
    // Style.settingsCellTextColor
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Style.settingsCellTextColor]
    // self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.navigationBar.barTintColor = Style.settingsCellBackgroundColor
    self.navigationController?.navigationBar.tintColor = Style.settingsCellTextColor
    
  }
  
  func updateWallpaper() {
    guard let wallpaper = Datas.shared.settings["wallpaper"] as? String else { return }
    
    if wallpaper == "None" {
      self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
      // tableView.backgroundColor = Style.wallpaperColor
      
    } else {
      guard let blur: Bool = Datas.shared.settings["wallpaperBlur"] as? Bool else { return }
      setWallpaper(blur: blur)
      
      // tableView.backgroundColor = Style.wallpaperTintColor
      
    }
    
  }
  
  
  
  func setWallpaper(blur: Bool) {
    // Adding background wallpaper
    
    let wallpaperFile = Datas.shared.getWallpaperFilename()
    
    let wallpaper: UIImageView = UIImageView(image: UIImage(named: wallpaperFile))
    
    if blur {
      wallpaper.blurImage(id: wallpaperFile, blurValue: 5)
    }

    tableView.backgroundView = wallpaper
    
  }
  
  func getVersion() -> String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      return version
    } else {
      return ""
    }
  }
  
  func setupForm() {
    form
      +++ Section("Design")
      
      <<< ActionSheetRow<String>() {
        $0.title = "Theme"
        $0.selectorTitle = "Choose a theme"
        $0.value = Datas.shared.settings["theme"] as? String
        $0.options = Style.themes
        
        }.onChange { row in
          Style.setTheme(colour: (row.value)!)
          self.updateRows()
          
      }
      
      <<< ActionSheetRow<String>() {
        $0.title = "Wallpaper"
        $0.selectorTitle = "Choose a wallpaper"
        $0.value = Datas.shared.settings["wallpaper"] as? String
        $0.options = Datas.shared.wallpapers
        
        }.onChange { row in
          guard let myValue: String = row.value else { return }
          
          Datas.shared.settings.updateValue(myValue, forKey: "wallpaper")
          self.updateWallpaper()
          
      }
      
      <<< CheckRow() {
        $0.title = "Show wallpaper blur"
        $0.value = Datas.shared.settings["wallpaperBlur"] as? Bool
        
        }.onChange { row in
          Datas.shared.settings.updateValue(row.value!, forKey: "wallpaperBlur")
          self.updateWallpaper()
          
      }
      
      <<< CheckRow() {
        $0.title = "Show sound button blur"
        $0.tag = "trackBlurTag"
        $0.value = Datas.shared.settings["trackBlur"] as? Bool
        }.onChange { row in
          Datas.shared.settings.updateValue(row.value!, forKey: "trackBlur")
          
      }
      
      
      //      +++ Section("Playback")
      //      <<< CheckRow() {
      //        $0.title = "Play sounds simultaneously"
      //        $0.value = true
      //      }
      
      +++ Section("Help improve the app")
      
      <<< LabelRow() {
        $0.title = "Send us feedback"
        $0.value = ">"
        }.onCellSelection { cell, row in
          let email = "hello@roguestudios.co"
          if let feedbackURL = URL(string: "mailto:\(email)?subject=I%20have%20feedback%20for%20Rick%20and%20Morty%20Soundboard%20iOS!%20-%20v\(self.getVersion())") {
            UIApplication.shared.open(feedbackURL, options: [:], completionHandler: nil)
          }
      }
      
      <<< LabelRow() {
        $0.title = "Leave a review"
        $0.value = ">"
        }.onCellSelection { cell, row in
          // TODO: Wrong app store link! This is for 100!
          
          // Note: Opening App Store via external URLs is a bad idea for experience fluidity
          // let address = "https://smarturl.it/RicknMortySoundboard"
          // https://itunes.apple.com/app/id1262813325 <- 100 app page
          let address = "https://itunes.apple.com/developer/id1262813324"
          if let appStoreURL = URL(string: address) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
          }
      }
      
      +++ Section("About")
      
      <<< LabelRow() {
        $0.title = "Built with 💚 by Rick & Morty fans"
        $0.cell.backgroundColor = UIColor.clear
      }
      
      <<< LabelRow() {
        $0.title = "More by Rogue Studios"
        $0.value = ">"
        }.onCellSelection { cell, row in
          // let url = URL(string: "https://smarturl.it/byRogueStudios")!
          let url = URL(string: "https://itunes.apple.com/developer/id1262813324")!
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
      
      <<< LabelRow() {
        $0.title = "Version \(getVersion())"
    }
    
  }
  
}

class CustomNavigationBar: UINavigationBar {
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let newSize :CGSize = CGSize(width: self.frame.size.width, height: 54)
    return newSize
  }
}
