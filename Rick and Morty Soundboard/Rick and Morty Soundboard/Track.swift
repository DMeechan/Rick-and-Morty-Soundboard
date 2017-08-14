//
//  Track.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class Track {
  
  static let blurredImageCache = NSCache<AnyObject, AnyObject>()
  
  var name: String = "jerry"
  var image: String = "jerry_char"
  var soundFileName: String = "lick my balls_sound"
  
  init(dataDictionary: [String: String]) {
    name = dataDictionary["name"]!
    
    image = dataDictionary["image"]!
    image.append("_char")
    
    soundFileName = dataDictionary["sound"]!
    soundFileName.append("_sound")
    
  }
  
  init() {
    name = "rick_char"
    image = "rick_char"
    soundFileName = "lick my balls_sound"
    
  }
  
  class func newTrack(dataDictionary: [String: String]) -> Track {
    return Track(dataDictionary: dataDictionary)
    
  }
  
}
