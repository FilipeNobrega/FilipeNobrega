//
//  ExperienceTile.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct ExperienceTile: Tile, Decodable {
  let shortDescription: String
  let type: TileType = .experience
  let headerImage: String

  init(shortDescription: String, headerImage: String) {
    self.shortDescription = shortDescription
    self.headerImage = headerImage
  }
}
