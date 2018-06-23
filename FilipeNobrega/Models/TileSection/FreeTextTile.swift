//
//  FreeTextTile.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct FreeTextTile: Tile, Decodable {
  let shortDescription: String
  let type: TileType = .freeText
  let headerImage: String
  
  var longDescription: String?

  init(shortDescription: String, headerImage: String) {
    self.shortDescription = shortDescription
    self.headerImage = headerImage
  }
}
