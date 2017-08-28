//
//  Track.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

let blurredImageCache = NSCache<AnyObject, AnyObject>()

class Track {
  
  var sound: String = ""
  var character: String = ""
  
//  var name: String = "jerry"
//  var image: String = "jerry_char"
//  var soundFileName: String = "lick my balls_sound"
  
  init(dataDictionary: [String: String]) {
    // New way to import tracks
    sound = dataDictionary["sound"]!
    character = dataDictionary["character"]!
    
    character.append("_char")
//    sound.append("_sound")
    
    
    // Original way of importing tracks
    
//    name = dataDictionary["name"]!
//    image = dataDictionary["image"]!
//    
//    image.append("_char")
//    
//    soundFileName = dataDictionary["sound"]!
//    soundFileName.append("_sound")
    
  }
  
  init() {
    
    sound = "lick my balls"
    character = "rick_char"
    
//    name = "rick_char"
//    image = "rick_char"
//    soundFileName = "lick my balls_sound"
//    
  }
  
  class func newTrack(dataDictionary: [String: String]) -> Track {
    return Track(dataDictionary: dataDictionary)
    
  }
  
  func isUnique() -> Bool {
    for existingTrack in DataManager.shared.tracks {
      if self.sound == existingTrack.sound {
        print("Track \(self.sound) has a duplicate! Attempting to correct.")
        return false
        
      }
    }
    
    return true
    
  }
  
}

extension UIImageView {
  
  func blurImage(id: String) {
    
    blurImage(id: id, blurValue: 2)
    
  }
  
  func blurImage(id: String, blurValue: Int) {
    
    if let imageFromCache = blurredImageCache.object(forKey: id as AnyObject) {
      self.image = imageFromCache as? UIImage
      print("Grabbing blurred image from cache!")
      return
    }
    
    let processedImageToCache = blurImage(blurValue: blurValue)
    
    // Save blurred image to cache
    blurredImageCache.setObject(processedImageToCache, forKey: id as AnyObject)
    
    print("Processing blurred image")
    self.image = processedImageToCache
    
  }
  
  func blurImage(blurValue: Int) -> UIImage {
    let context = CIContext(options: nil)
    
    let currentFilter = CIFilter(name: "CIGaussianBlur")
    
    guard let image = self.image else { return UIImage() }
    let beginImage = CIImage(image: image)
    
    currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
    currentFilter!.setValue(blurValue, forKey: kCIInputRadiusKey)
    
    let cropFilter = CIFilter(name: "CICrop")
    cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
    cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
    
    let output = cropFilter!.outputImage
    let cgimg = context.createCGImage(output!, from: output!.extent)
    let processedImage = UIImage(cgImage: cgimg!)
    
    return processedImage
    
  }
  
  func blurImageApple() -> UIImageView {
    let blurEffect = UIBlurEffect(style: .light)
    let blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView.frame = self.bounds
    
    self.addSubview(blurredEffectView)
    let output: UIImageView = self
    
    return output
    
  }
  
}

extension UIImage{
  
  func alpha(_ value:CGFloat)->UIImage
  {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
    
  }
}
