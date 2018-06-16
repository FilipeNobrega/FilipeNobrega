//
//  InfoView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import UIKit

class InfoView: UIView {
  @IBOutlet weak var infoTableView: UITableView!
  @IBOutlet weak var avatarImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    infoTableView.dataSource = self
    infoTableView.delegate = self
    infoTableView.showsVerticalScrollIndicator = false
    infoTableView.showsHorizontalScrollIndicator = false
    infoTableView.isUserInteractionEnabled = false
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
  }

  public func getHeight() -> CGFloat {
    return infoTableView.contentSize.height + infoTableView.frame.origin.y
  }
}

extension InfoView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(44)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
    return cell
  }
}
