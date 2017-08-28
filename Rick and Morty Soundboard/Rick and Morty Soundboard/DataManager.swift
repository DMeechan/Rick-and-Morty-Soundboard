//
//  Datas.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 15/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

typealias Datas = DataManager

class DataManager {
  
  static let shared = Datas()
  
  var tracks = [Track]()
  var settings: [String: Any] = [:]
  
  let wallpapers: [String] = [
    "None",
    "Eating",
    "Criminal Rick"
  ]
  
  init() {
    
  }
  
  func setup() {
    importSettings()
    importTrackData()
    
    // saveData()
    
  }
  
  func saveData() {
    
    do {
      // Encode Tracks as JSON Data
      let jsonData = try JSONSerialization.data(withJSONObject: settings, options: .prettyPrinted)
      
      let jsonDecoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
      
      // Now cast it with the right type
      if let dictFromJSON = jsonDecoded as? [String:Any] {
        print("PRINTING SETTINGS JSON:")
        print(dictFromJSON)
      }
      
      // print(jsonToString(json: jsonData))
      
//      try! realm.write {
//        let jsonDecoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//        //realm.create(jsonDecoded)
//        
//      }
      
    } catch {
      print(error.localizedDescription)
      
    }
  }
  

//  func jsonToString(json: Any){
//    do {
//      let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//      let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
////      print(convertedString)
//      
//    } catch let myJSONError {
//      print(myJSONError)
//    }
//    
//  }
  
  
  func getWallpaperFilename() -> String {
    guard var wallpaper: String = Datas.shared.settings["wallpaper"] as? String else { return "" }
    
    wallpaper.append("_wallpaper")
    
    return wallpaper
    
  }
  
  func importTrackData() {
    var items = [Track]()
    
    let inputFile = Bundle.main.path(forResource: "trackData", ofType: "plist")
    
    let inputDataArray = NSArray(contentsOfFile: inputFile!)
    
    for item in inputDataArray as! [Dictionary<String, String>] {
      let track = Track(dataDictionary: item)
      
      if track.isUnique() == false {
        track.name += "2"
      }
      
      items.append(track)
      
    }
    
    tracks = items
    
  }
  
  func importSettings() {
    settings  = [
      "wallpaper": "Eating",
      "theme": Style.themes[0],
      "wallpaperBlur": false,
      "trackBlur": false,
      "simultaneousPlayback": false,
      "enableFavourites": false,
      "isDeveloper": true
    ]
  }
  
  func getBoolFromSetting(id: String) -> Bool {
    //    if settings[id] == "true" {
    //      return true
    //
    //    }
    //
    return false
    
  }
  
}

extension String{
  func dictionaryValue() -> [String: AnyObject]
  {
    if let data = self.data(using: String.Encoding.utf8) {
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]
        return json!
        
      } catch {
        print("Error converting to JSON")
      }
    }
    return NSDictionary() as! [String : AnyObject]
  }
}

extension NSDictionary{
  func JsonString() -> String
  {
    do{
      let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      return String.init(data: jsonData, encoding: .utf8)!
    }
    catch
    {
      return "error converting"
    }
  }
}
