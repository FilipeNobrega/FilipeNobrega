//
//  CollegeSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxDataSources

struct CollegeSection: Decodable {
  let items: [College]
}

extension CollegeSection: SectionModelType {
  typealias Item = College

  init(original: CollegeSection, items: [Item]) {
    self.items = items
  }
}
