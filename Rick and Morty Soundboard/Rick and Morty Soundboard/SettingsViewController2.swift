//
//  SettingsViewController2.swift
//  Rick and Morty Soundboard
//
//  Created by Daniel Meechan on 14/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class SettingsViewController2: UITableViewController {
  
  static var settings: [String: AnyObject] = [:]
  
  //// Sectins:
  // Playback
  // Design
  // About
  
  var items = ["abc", "def", "ghi", "jkl"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
    tableView.register(SettingsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SettingsTableViewHeader")
    
    tableView.sectionHeaderHeight = 50
    
    // self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[tableView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["tableView": tableView]))
    
  }
  
  func closeView() {
    dismiss(animated: true, completion: nil)
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Give cells their contents
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
    cell.nameLabel.text = items[indexPath.row]
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return number of rows in a section
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsTableViewHeader")
    
  }
  
  
}
