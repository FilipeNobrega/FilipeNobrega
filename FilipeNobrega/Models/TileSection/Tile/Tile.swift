//
//  Tile.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

enum TileError: Error {
  case unhandled
}

enum TileType: String, Decodable {
  case freeText = "FreeText"
  case education = "Education"
  case experience = "Experience"
}

protocol Tile: GenericItemType {
  var shortDescription: String { get }
  var type: TileType { get }
  var headerImage: String  { get }
}

extension Tile {
  var identifier: String {
    return String(describing: type.rawValue)
  }
}

struct FailableTile: Decodable {
  let tile: Tile?

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let tile = try? container.decode(FreeTextTile.self), tile.type == .freeText {
      self.tile = tile
    } else if let tile = try? container.decode(EducationTile.self), tile.type == .education {
      self.tile = tile
    } else if let tile = try? container.decode(ExperienceTile.self), tile.type == .experience {
      self.tile = tile
    } else {
      throw TileError.unhandled
    }
  }
}
