//
//  AppCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class AppCollectionViewCell: UICollectionViewCell, GenericCellType {
  typealias Item = AppTile

  @IBOutlet weak private var appIconImageView: UIImageView!

  func prepare(with item: Item) {
    // prepare cell.
  }
}
