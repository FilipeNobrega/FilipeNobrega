//
//  ContactCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class ContactCell: UITableViewCell {
  @IBOutlet weak private var iconView: UIImageView!
  @IBOutlet weak private var descriptionLabel: UILabel!
  @IBOutlet weak var separatorView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    descriptionLabel.textColor = StyleGuides.secundaryColor
    separatorView.backgroundColor = StyleGuides.secundaryColor
    separatorView.alpha = StyleGuides.tableViewSeparatorAlpha
  }

  func prepare(with field: ContactField) {
    descriptionLabel.text = field.text
  }

  override func prepareForReuse() {
    descriptionLabel.text = nil
  }
}
