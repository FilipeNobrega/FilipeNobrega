//
//  ContactInfo.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxDataSources

struct ContactInfo: Decodable {
  let avatar: URL
  let fields: [ContactField]
}

extension ContactInfo: SectionModelType {
  typealias Item = ContactField

  var items: [ContactField] {
    return fields
  }

  init(original: ContactInfo, items: [ContactField]) {
    fields = items
    self.avatar = original.avatar
  }
}
