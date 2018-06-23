//
//  FooterView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

final class FooterView: UIView {
  @IBOutlet weak var footerCollectionView: UICollectionView!

  private let disposeBag = DisposeBag()

  override func awakeFromNib() {
    super.awakeFromNib()
    footerCollectionView.showsVerticalScrollIndicator = false
    footerCollectionView.showsHorizontalScrollIndicator = false

    prepareBinds()
  }

  private func prepareBinds() {
    let sections = FooterSection.mockInfo()

    let dataSource = InfoView.dataSource()

    Observable.just(sections)
      .bind(to: footerCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}

private extension InfoView {
  static func dataSource() -> RxCollectionViewSectionedReloadDataSource<FooterSection> {
    return RxCollectionViewSectionedReloadDataSource<FooterSection>(configureCell: {
      (dataSource, collection, indexPath, cellType) -> UICollectionViewCell in
      let cell =
        collection.dequeueReusableCell(withReuseIdentifier: "footerCell",
                                       for: indexPath)
      return cell
    })
  }
}
