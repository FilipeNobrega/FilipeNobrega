//
//  FooterSectionView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class FooterSectionView: UIView {
  @IBOutlet weak private var footerCollectionView: UICollectionView!

  private let disposeBag = DisposeBag()

  override func awakeFromNib() {
    super.awakeFromNib()
    footerCollectionView.showsVerticalScrollIndicator = false
    footerCollectionView.showsHorizontalScrollIndicator = false
  }

  func prepareBind(_ driver: Driver<[FooterSection]>) {
    let dataSource = CollectionViewDataSource<AppCollectionViewCell, FooterSection>
      .dataSource()

    driver
      .drive(footerCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
