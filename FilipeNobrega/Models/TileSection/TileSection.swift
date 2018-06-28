//
//  TileSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxDataSources

struct TileSection: Decodable {
  var items: [Tile] = []

  init(items: [Tile]) {
    self.items = items
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let tiles = try? container.decode([FailableTile].self) {
      items = tiles.compactMap { $0.tile }
    }
  }
}

extension TileSection: SectionModelType {
  typealias Item = Tile

  init(original: TileSection, items: [Item]) {
    self.items = items
  }
}
