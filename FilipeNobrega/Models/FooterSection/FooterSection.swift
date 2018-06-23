//
//  FooterSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import RxDataSources

struct FooterSection: Decodable {
  let items: [AppTile]
}

extension FooterSection: SectionModelType {
  typealias Item = AppTile

  init(original: FooterSection, items: [AppTile]) {
    self.items = items
  }
}

extension FooterSection {
  static func mockInfo() -> [FooterSection] {
    var appTiles = [AppTile]()
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    appTiles.append(AppTile(appIcon: "some"))
    return [FooterSection(items: appTiles)]
  }
}
