//
//  Style.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 15/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation
import ChameleonFramework

typealias Style = StyleManager

struct StyleManager {
  
  // Core colours
  static var primaryColor = UIColor()
  static var secondaryColor = UIColor()
  
  // Tracks View
  static var trackTextColor = UIColor()
  static var trackBorderColor = UIColor()
  static var trackIconColor = UIColor()
  
  static var trackFont = UIFont()
  
  static var settingsIconColor = UIColor()
  
  // Settings View
  
  static var settingsCellBackgroundColor = UIColor()
  static var settingsCellTextColor = UIColor()
  
  static var settingsFont = UIFont()
  
  // Both views
  
  // Tint is used for just overlaying an image; colour is used for actulal background colour
  static var wallpaperTintColor = UIColor()
  static var wallpaperColor = UIColor()
  
  static func setupTheme() {
    setThemeWhite()
    // Chameleon.setGlobalThemeUsingPrimaryColor(primaryColor, withSecondaryColor: secondaryColor, andContentStyle: UIContentStyle.contrast)
    
  }
  
  init() {
    Style.setupTheme()
  }
  
  static func setThemeWhite() {
    primaryColor = FlatWhite()
    secondaryColor = FlatBlack()
    
    DataManager.shared.settings.updateValue("Snowball White", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemeBlue() {
    // Meeseek blue: #64C7EE
    primaryColor = UIColor(red:0.39, green:0.78, blue:0.93, alpha:1.0)
    secondaryColor = UIColor.white
    
    DataManager.shared.settings.updateValue("Meeseek Blue", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemeGreen() {
    // Pickle Rick:
    // - light green: #649923 <- in use
    // - dark green: #4D7F1E
    // - darker green: #376306
    
    primaryColor = UIColor(red:0.39, green:0.60, blue:0.14, alpha:1.0)
    secondaryColor = UIColor.white
    
    // primaryColor = FlatMint()
    // secondaryColor = FlatForestGreenDark()
    DataManager.shared.settings.updateValue("Pickle Rick Green", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemePink() {
    // Noob Noob: #DD7290
    
    primaryColor = UIColor(red:0.87, green:0.45, blue:0.56, alpha:1.0)
    secondaryColor = UIColor.white
    
    DataManager.shared.settings.updateValue("Noob-Noob Pink", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemeOrange() {
    // Squanchy: #D6A01F
    
    primaryColor = UIColor(red:0.84, green:0.63, blue:0.12, alpha:1.0)
    secondaryColor = UIColor.white
    
    DataManager.shared.settings.updateValue("Squanchy Orange", forKey: "theme")
    setTheme()
    
  }
  
  static func setTheme() {
    setTheme(primary: primaryColor, secondary: secondaryColor)
  }
  
  static let themes = [
    "Snowball White", "Meeseek Blue", "Pickle Rick Green", "Noob-Noob Pink", "Squanchy Orange"
  ]
  
  static func setTheme(colour: String) {
    DataManager.shared.settings.updateValue(colour, forKey: "theme")
    
    switch (colour) {
    case "Snowball White": setThemeWhite()
    case "Meeseek Blue": setThemeBlue()
    case "Pickle Rick Green": setThemeGreen()
    case "Noob-Noob Pink": setThemePink()
    case "Squanchy Orange": setThemeOrange()
    default: break
    }
    
  }
  
  static func setTheme(primary: UIColor, secondary: UIColor) {
    
    // Tracks View
    trackTextColor = primary
    trackBorderColor = primary
    trackIconColor = primary
    
    settingsIconColor = primary
    
    trackFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
    
    // Settings View
    
    settingsCellBackgroundColor = primary.withAlphaComponent(0.7)
    settingsCellTextColor = secondary
    
    settingsFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
    
    // Both views
    
    wallpaperTintColor = secondary
    wallpaperColor = UIColor.white
    
  }
  
  
}
