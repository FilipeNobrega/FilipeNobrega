//
//  InfoSectionView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class InfoSectionView: UIView {
  @IBOutlet weak private var infoTableView: UITableView!
  @IBOutlet weak private var avatarImageView: UIImageView!
  @IBOutlet weak private var topSeparatorView: UIView!

  private var imageDisposable: Disposable?
  private let disposeBag = DisposeBag()

  override func awakeFromNib() {
    super.awakeFromNib()
    infoTableView.showsVerticalScrollIndicator = false
    infoTableView.showsHorizontalScrollIndicator = false
    infoTableView.isUserInteractionEnabled = false
    avatarImageView.rounded()
    topSeparatorView.backgroundColor = StyleGuides.secundaryColor
    topSeparatorView.alpha = StyleGuides.tableViewSeparatorAlpha
  }

  public func getHeight() -> CGFloat {
    return infoTableView.contentSize.height + infoTableView.frame.origin.y
  }

  func prepareBind(_ driver: Driver<[ContactInfo]>) {
    let dataSource = TablewViewDataSource<ContactTableViewCell, ContactInfo>.dataSource()

    driver
      .do(onNext: { [unowned self] contactInfo in
        self.fetchAvatarImage(from: contactInfo.first)
      }).drive(infoTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }

  private func fetchAvatarImage(from contactInfo: ContactInfo?) {
    guard let contactInfo = contactInfo else { return }
    imageDisposable?.dispose()
    imageDisposable = ImageServiceAPI.image(from: contactInfo.avatar)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [weak self] image in
        self?.avatarImageView.image = image
      })
  }
}
