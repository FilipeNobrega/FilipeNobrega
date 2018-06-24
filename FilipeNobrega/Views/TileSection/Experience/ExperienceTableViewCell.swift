//
//  ExperienceTableViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 12/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = StyleGuides.primaryTextColor
    subtitleLabel.textColor = StyleGuides.secundaryTextColor
    descriptionLabel.textColor = StyleGuides.primaryTextColor
    containerView.addShadow()
    containerView.roundedCorners()
    let loren = " • Lorem ipsum dolor sit amet, consectetur adipiscing elit. In augue dolor, semper quis aliquet sed, porta sit amet nunc. Pellentesque non arcu a sapien dictum sollicitudin."
    let rand = arc4random() % 4
    var text = loren
    for _ in 0...rand {
      text += "\n\n\(loren)"
    }
    descriptionLabel.text = text
  }
}
