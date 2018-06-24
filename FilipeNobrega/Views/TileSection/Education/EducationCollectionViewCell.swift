//
//  EducationCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class EducationCollectionViewCell: UICollectionViewCell, TileCollectionViewCellProtocol {
  override func awakeFromNib() {
    super.awakeFromNib()
    roundedCorners()
  }

  func prepare(with item: Tile) {
    //
  }
}
