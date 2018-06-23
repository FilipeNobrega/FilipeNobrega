//
//  TileSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import RxDataSources

struct TileSection: Decodable {
  var items: [Tile] = []

  init(items: [Tile]) {
    self.items = items
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if  let tiles = try? container.decode([FailableTile].self) {
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

extension TileSection {
  static func mockTiles() -> [TileSection] {
    let loren = " • Lorem ipsum dolor sit amet, consectetur adipiscing elit. In augue dolor, semper quis aliquet sed, porta sit amet nunc. Pellentesque non arcu a sapien dictum sollicitudin."
    var tiles = [Tile]()
    tiles.append(FreeTextTile(shortDescription: loren, headerImage: "none"))
    tiles.append(ExperienceTile(shortDescription: loren, headerImage: "none"))
    tiles.append(EducationTile(shortDescription: loren, headerImage: "none"))
    tiles.append(FreeTextTile(shortDescription: loren, headerImage: "none"))
    return [TileSection(items: tiles)]
  }
}
