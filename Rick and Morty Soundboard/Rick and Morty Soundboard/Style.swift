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
  
  // Settings View

  static var settingsHeaderBackgroundColor = UIColor()
  static var settingsHeaderTextColor = UIColor()
  
  static var settingsCellBackgroundColor = UIColor()
  static var settingsCellTextColor = UIColor()
  
  static var settingsFont = UIFont()
  
  // Both views
  
  static var wallpaperTintColor = UIColor()

  
  static func setupTheme() {
    Chameleon.setGlobalThemeUsingPrimaryColor(primaryColor, withSecondaryColor: secondaryColor, andContentStyle: UIContentStyle.contrast)
    
  }

  
  static func setThemeLight() {
    primaryColor = FlatWhite()
    secondaryColor = FlatBlack()
    setTheme()
    
  }
  
  static func setThemeDark() {
    primaryColor = FlatBlack()
    secondaryColor = FlatWhite()
    setTheme()
    
  }
  
  static func setTheme() {
    setTheme(primary: primaryColor, secondary: secondaryColor)
  }
  
  static func setTheme(primary: UIColor, secondary: UIColor) {
    // Tracks View
    trackTextColor = primary
    trackBorderColor = primary
    trackIconColor = primary
    
    trackFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
    
    // Settings View
    
    settingsHeaderBackgroundColor = secondary.withAlphaComponent(0.1)
    settingsHeaderTextColor = primary
    
    settingsCellBackgroundColor = primary.withAlphaComponent(0.8)
    settingsCellTextColor = secondary
    
    settingsFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
    
    // Both views
    
    wallpaperTintColor = primary
    
  }
  
  
}
