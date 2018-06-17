//
//  BaseCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 12/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 5
  }
}
