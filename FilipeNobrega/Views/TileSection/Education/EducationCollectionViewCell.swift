//
//  EducationCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class EducationCollectionViewCell: UICollectionViewCell, TilableViewProtocol {
  @IBOutlet weak private var descriptionLabel: UILabel!
  @IBOutlet weak private var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = StyleGuides.primaryTextColor
    descriptionLabel.textColor = StyleGuides.primaryTextColor
    roundedCorners()
  }

  func prepare(with tile: Tile) {
    descriptionLabel.text = tile.shortDescription
    titleLabel.text = tile.title
  }
}
