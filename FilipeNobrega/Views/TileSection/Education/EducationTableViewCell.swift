//
//  EducationTableViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class EducationTableViewCell: UITableViewCell, GenericCellType {
  typealias Item = College

  @IBOutlet weak private var collegeImageView: UIImageView!
  @IBOutlet weak private var nameLabel: UILabel!
  @IBOutlet weak private var majorLabel: UILabel!
  @IBOutlet weak private var observationLabel: UILabel!
  @IBOutlet weak private var observationBaselineConstraint: NSLayoutConstraint!

  private var imageDisposable: Disposable?

  override func awakeFromNib() {
    super.awakeFromNib()
    nameLabel.textColor = StyleGuides.primaryTextColor
    majorLabel.textColor = StyleGuides.primaryTextColor
    observationLabel.textColor = StyleGuides.secundaryTextColor
  }

  func prepare(with item: College) {
    nameLabel.text = item.title
    majorLabel.text = item.major
    imageDisposable = ImageServiceAPI.image(from: item.image)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [weak self] image in
        self?.collegeImageView.image = image
      })
    if let observation = item.observation {
      observationLabel.text = observation
      observationBaselineConstraint.constant = 25
    } else {
      observationLabel.text = nil
      observationBaselineConstraint.constant = 0
    }
    setNeedsLayout()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    majorLabel.text = nil
    observationLabel.text = nil
    imageDisposable?.dispose()
    imageDisposable = nil
  }
}
