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
  var headerImage: URL { get }
}

extension Tile {
  var identifier: String {
    return String(describing: type.rawValue)
  }
}

extension Tile {
  static func equals(lhs: Tile, rhs: Tile) -> Bool {
    guard lhs.shortDescription == rhs.shortDescription else { return false }
    guard lhs.headerImage == rhs.headerImage else { return false }
    return true
  }
}

struct AnyTile: Equatable {
  let tile: Tile

  static func ==(lhs: AnyTile, rhs: AnyTile) -> Bool {
    guard lhs.tile.type == rhs.tile.type else { return false }
    switch (lhs.tile, rhs.tile) {
    case let (lhs as FreeTextTile, rhs as FreeTextTile):
      return lhs == rhs
    case let (lhs as EducationTile, rhs as EducationTile):
      return lhs == rhs
    case let (lhs as ExperienceTile, rhs as ExperienceTile):
      return lhs == rhs
    default:
      return false
    }
  }

  init(_ base: Tile) {
    tile = base
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
