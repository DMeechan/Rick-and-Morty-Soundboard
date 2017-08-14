//
//  Track.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 13/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class Track {
  
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

let blurredImageCache = NSCache<AnyObject, AnyObject>()

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
    let beginImage = CIImage(image: self.image!)
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
