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
  
  let image: String
  let name: String
  let major: String
  let observation: String?
}
