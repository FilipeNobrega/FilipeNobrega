//
//  ContactInfo.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import RxDataSources

struct ContactInfo: Decodable {
  let avatar: String
  let fields: [ContactField]

  var avatarUrl: URL? {
    return URL(string: avatar)
  }
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

extension ContactInfo {
  static func mockInfo() -> [ContactInfo] {
    var fields = [ContactField]()
    fields.append(ContactField(icon: "https://via.placeholder.com/50x50", text: "Skype"))
    fields.append(ContactField(icon: "https://via.placeholder.com/50x50", text: "Tel"))
    fields.append(ContactField(icon: "https://via.placeholder.com/50x50", text: "Email"))
    fields.append(ContactField(icon: "https://via.placeholder.com/50x50", text: "Github"))
    fields.append(ContactField(icon: "https://via.placeholder.com/50x50", text: "Linkedin"))
    return [ContactInfo(avatar: "avatar", fields: fields)]
  }
}
