//
//  CompanySection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxDataSources

struct CompanySection: Decodable {
  let items: [Company]
}

extension CompanySection: SectionModelType {
  typealias Item = Company

  init(original: CompanySection, items: [Item]) {
    self.items = items
  }
}
