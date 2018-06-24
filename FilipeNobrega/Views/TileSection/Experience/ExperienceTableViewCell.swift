//
//  ExperienceTableViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 12/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class ExperienceTableViewCell: UITableViewCell, GenericCellType {
  typealias Item = Company

  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var imageVIew: UIImageView!
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var subtitleLabel: UILabel!
  @IBOutlet weak private var descriptionLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = StyleGuides.primaryTextColor
    subtitleLabel.textColor = StyleGuides.primaryTextColor
    descriptionLabel.textColor = StyleGuides.primaryTextColor
    containerView.addShadow()
    containerView.roundedCorners()
  }

  func prepare(with item: Company) {
    titleLabel.text = item.title
    subtitleLabel.text = item.subtitle
    descriptionLabel.text = item.description
  }
}
