//
//  ContactTableViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ContactTableViewCell: UITableViewCell, GenericCellType {
  typealias Item = ContactField

  @IBOutlet weak private var iconView: LoadingImageView!
  @IBOutlet weak private var descriptionLabel: UILabel!
  @IBOutlet weak private var separatorView: UIView!

  private var imageDisposable: Disposable?

  override func awakeFromNib() {
    super.awakeFromNib()
    descriptionLabel.textColor = StyleGuides.secundaryColor
    separatorView.backgroundColor = StyleGuides.secundaryColor
    separatorView.alpha = StyleGuides.tableViewSeparatorAlpha
  }

  func prepare(with item: Item) {
    descriptionLabel.text = item.text
    imageDisposable = ImageServiceAPI.image(from: item.icon)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [weak self] image in
        self?.iconView.image = image
      })
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageDisposable?.dispose()
    imageDisposable = nil
    descriptionLabel.text = nil
  }
}
