//
//  Layout.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 25/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//


struct Layout: Decodable {
  let contactInfo: ContactInfo
  let tileSection: TileSection
  let footerSection: FooterSection
}

extension Layout: Equatable {
  static func == (lhs: Layout, rhs: Layout) -> Bool {
    guard lhs.contactInfo == rhs.contactInfo else { return false }
    guard lhs.tileSection == rhs.tileSection else { return false }
    guard lhs.footerSection == rhs.footerSection else { return false }
    return true
  }
}

