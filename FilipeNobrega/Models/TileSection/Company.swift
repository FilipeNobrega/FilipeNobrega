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
  
  let image: String
  let title: String
  let subtitle: String
  let description: String
}
