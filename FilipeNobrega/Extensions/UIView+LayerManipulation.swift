//
//  UIView+LayerManipulation.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 12/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

extension UIView {
  func roundedCorners() {
    layer.cornerRadius = 5
  }

  func addShadow() {
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowRadius = 5
    layer.shadowOpacity = 0.25
  }

  func rounded() {
    guard frame.size.height == frame.size.width else { return }
    clipsToBounds = true
    layer.cornerRadius = frame.size.height / 2
  }
}
