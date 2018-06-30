//
//  CGRect+Center.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 30/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

extension CGRect {
  var center: CGPoint {
    return CGPoint(x: origin.x + size.width / 2,
                   y: origin.y + size.height / 2)
  }
}
