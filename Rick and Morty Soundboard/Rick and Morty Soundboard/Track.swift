//
//  Track.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

class Track {
    
    var image: String
    var name: String = "wubba lubba dub dub"
    var soundFileName: String = "lick my balls"
    
    init(dataDictionary: [String: String]) {
        image = dataDictionary["image"]!
        soundFileName = dataDictionary["sound"]!
    }
    
    class func newTrack(dataDictionary: [String: String]) -> Track {
        return Track(dataDictionary: dataDictionary)
    }
    
}