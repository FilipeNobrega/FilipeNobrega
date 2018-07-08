//
//  EducationTile.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct EducationTile: Tile, Decodable {
  let title: String
  let shortDescription: String
  let type: TileType
  let headerImage: URL
  let colleges: [College]
}

extension EducationTile: Equatable {
  static func == (lhs: EducationTile, rhs: EducationTile) -> Bool {
    guard EducationTile.equals(lhs: lhs, rhs: rhs) else { return false }
    guard lhs.colleges == rhs.colleges else { return false }
    return true
  }
}
