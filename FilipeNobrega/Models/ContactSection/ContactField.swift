//
//  ContactField.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct ContactField: Decodable, GenericItemType {
  var identifier: String {
    return String(describing: ContactField.self)
  }
  
  let icon: URL
  let text: String
}

extension ContactField: Equatable {
  static func == (lhs: ContactField, rhs: ContactField) -> Bool {
    guard lhs.icon == rhs.icon else { return false }
    guard lhs.text == rhs.text else { return false }
    return true
  }
}
