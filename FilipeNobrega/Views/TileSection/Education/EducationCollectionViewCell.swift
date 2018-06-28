//
//  EducationCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class EducationCollectionViewCell: UICollectionViewCell, TilableViewProtocol {
  @IBOutlet weak var descriptionLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    roundedCorners()
  }

  func prepare(with tile: Tile) {
    descriptionLabel.text = tile.shortDescription
  }
}
