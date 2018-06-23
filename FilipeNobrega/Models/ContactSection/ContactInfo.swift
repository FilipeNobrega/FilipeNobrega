//
//  ContactInfo.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct ContactInfo: Decodable {
  let avatar: String
  let fields: [ContactInfo]

  var avatarUrl: URL? {
    return URL(string: avatar)
  }
}
