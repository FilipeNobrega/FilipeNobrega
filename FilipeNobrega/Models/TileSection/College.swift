//
//  College.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct College: Decodable, GenericItemType {
  var identifier: String {
    return String(describing: College.self)
  }
  
  let image: URL
  let title: String
  let major: String
  let observation: String?
}

extension College: Equatable {
  static func == (lhs: College, rhs: College) -> Bool {
    guard lhs.image == rhs.image else { return false }
    guard lhs.title == rhs.title else { return false }
    guard lhs.major == rhs.major else { return false }
    guard lhs.observation == rhs.observation else { return false }
    return true
  }
}
