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

  static let themes = [
    "White", "Meeseek Blue", "Green", "Red"
  ]
  
  static func setThemeWhite() {
    primaryColor = FlatWhite()
    secondaryColor = FlatBlack()
    DataManager.shared.settings.updateValue("White", forKey: "theme")
    setTheme()
  
  }
  
  static func setThemeBlue() {
    // Meeseek blue: #64C7EE
    primaryColor = UIColor(red:0.39, green:0.78, blue:0.93, alpha:1.0)
    
    // primaryColor = FlatPowderBlue()
    secondaryColor = FlatNavyBlueDark()
    DataManager.shared.settings.updateValue("Blue", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemeGreen() {
    primaryColor = FlatMint()
    secondaryColor = FlatForestGreenDark()
    DataManager.shared.settings.updateValue("Green", forKey: "theme")
    setTheme()
    
  }
  
  static func setThemeRed() {
    primaryColor = FlatWatermelon()
    secondaryColor = FlatMaroon()
    DataManager.shared.settings.updateValue("Red", forKey: "theme")
    setTheme()
    
  }
  
  static func setTheme() {
    setTheme(primary: primaryColor, secondary: secondaryColor)
  }
  
  static func setTheme(colour: String) {
    switch (colour) {
    case "White": setThemeWhite()
    case "Meeseek Blue": setThemeBlue()
    case "Green": setThemeGreen()
    case "Red": setThemeRed()
    default: break
    }
    
  }

  static func setTheme(primary: UIColor, secondary: UIColor) {
    
    // Tracks View
    trackTextColor = primary
    trackBorderColor = primary
    trackIconColor = primary
    
    settingsIconColor = primary
    
    trackFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
    
    // Settings View
    
    settingsCellBackgroundColor = primary.withAlphaComponent(0.9)
    settingsCellTextColor = secondary
    
    settingsFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
    
    // Both views
    
    wallpaperTintColor = secondary
    wallpaperColor = UIColor.white
    
  }
  
  
}
