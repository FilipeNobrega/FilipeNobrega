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
  let type: TileType
  let headerImage: URL
  
  var longDescription: String?
}
