//
//  CollegeSection.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
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

extension CollegeSection {
  static func mockInfo() -> [CollegeSection] {
    var colleges = [College]()
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: "some"))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: nil))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: nil))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: nil))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: "some"))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: nil))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: "some"))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: nil))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: "some"))
    colleges.append(College(image: "some", name: "Universidade Federal do Rio Grande do Norte", major: "Universidade Federal do Rio Grande do Norte", observation: "some"))
    return [CollegeSection(items: colleges)]
  }
}
