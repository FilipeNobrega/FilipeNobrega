//
//  AppTile.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct AppTile: Decodable, GenericItemType {
  var identifier: String {
    return String(describing: AppTile.self)
  }

  let appIcon: URL
}

extension AppTile: Equatable {
  static func == (lhs: AppTile, rhs: AppTile) -> Bool {
    return lhs.appIcon == rhs.appIcon
  }
}
