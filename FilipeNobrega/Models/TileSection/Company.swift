//
//  Company.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation

struct Company: Decodable, GenericItemType {
  var identifier: String {
    return String(describing: Company.self)
  }
  
  let image: URL
  let title: String
  let subtitle: String
  let description: String
}

extension Company: Equatable {
  static func == (lhs: Company, rhs: Company) -> Bool {
    guard lhs.image == rhs.image else { return false }
    guard lhs.title == rhs.title else { return false }
    guard lhs.subtitle == rhs.subtitle else { return false }
    guard lhs.description == rhs.description else { return false }
    return true
  }
}
