//
//  Data.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 15/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

typealias Data = DataManager

class DataManager {
  
  static let shared = Data()
  
  var settings: [String: String] = [:]
  
  init() {
    importSettings()
    
  }
  
  func importSettings() {
    settings = [
      "wallpaper": "true",
      "darkTheme": "false",
      "glassEffectOnWallpaper": "true",
      "glassEffectOnTracks": "true",
      // "longPressLoops": "true",
      "simultaneousPlayback": "false",
      "isDeveloper": "true"
    ]
  }
  
  func getBoolFromSetting(id: String) -> Bool {
    if settings[id] == "true" {
      return true
      
    }
    
    return false
    
  }
  
  
}
