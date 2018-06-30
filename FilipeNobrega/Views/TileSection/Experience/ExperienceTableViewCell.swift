//
//  ExperienceTableViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 12/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ExperienceTableViewCell: UITableViewCell, GenericCellType {
  typealias Item = Company

  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var imageVIew: LoadingImageView!
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var subtitleLabel: UILabel!
  @IBOutlet weak private var descriptionLabel: UILabel!

  private var imageDisposable: Disposable?

  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = StyleGuides.primaryTextColor
    subtitleLabel.textColor = StyleGuides.primaryTextColor
    descriptionLabel.textColor = StyleGuides.primaryTextColor
    containerView.addShadow()
    containerView.roundedCorners()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    subtitleLabel.text = nil
    descriptionLabel.text = nil
    imageDisposable?.dispose()
    imageDisposable = nil
    imageVIew.image = nil
  }

  func prepare(with item: Company) {
    titleLabel.text = item.title
    subtitleLabel.text = item.subtitle
    descriptionLabel.text = item.description
    imageDisposable = ImageServiceAPI.image(from: item.image)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [weak self] image in
        self?.imageVIew.image = image
      })
  }
}
