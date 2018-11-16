//
//  StyleGuides.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 16/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

struct StyleGuides {
  static var primaryColor = UIColor(red: 200, green: 200, blue: 200)
  static var secundaryColor = UIColor(red: 255, green: 255, blue: 255)
  static var primaryTextColor = UIColor(red: 60, green: 60, blue: 60)
  static var secundaryTextColor = UIColor(red: 140, green: 140, blue: 140)

  static var tableViewSeparatorAlpha: CGFloat = 0.3
}

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat = 1.0) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
  }
}
