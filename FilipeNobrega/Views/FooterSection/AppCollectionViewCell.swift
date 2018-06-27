//
//  AppCollectionViewCell.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class AppCollectionViewCell: UICollectionViewCell, GenericCellType {
  typealias Item = AppTile

  @IBOutlet weak private var appIconImageView: UIImageView!

  private var imageDisposable: Disposable?

  override func prepareForReuse() {
    super.prepareForReuse()
    imageDisposable?.dispose()
    imageDisposable = nil
    appIconImageView.image = nil
  }

  func prepare(with item: Item) {
    imageDisposable = ImageServiceAPI.image(from: item.appIcon)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [weak self] image in
        self?.appIconImageView.image = image
      })
  }
}
