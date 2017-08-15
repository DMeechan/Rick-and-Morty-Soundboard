//
//  SettingsTableViewCell.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 14/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello sample item"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
  }()
  
  
  func setupViews() {
    addSubview(nameLabel)
    
    let views: [String: AnyObject] = [
      "nameLabel": nameLabel
    ]
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[nameLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class SettingsTableViewHeader: UITableViewHeaderFooterView {
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello header"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
  }()
  
  func setupViews() {
    addSubview(nameLabel)
    
    let views: [String: AnyObject] = [
      "nameLabel": nameLabel
    ]
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[nameLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
