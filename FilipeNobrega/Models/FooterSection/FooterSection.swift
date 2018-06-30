//
//  FooterSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

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

extension FooterSection: Equatable {
  static func == (lhs: FooterSection, rhs: FooterSection) -> Bool {
    return lhs.items == rhs.items
  }
}
