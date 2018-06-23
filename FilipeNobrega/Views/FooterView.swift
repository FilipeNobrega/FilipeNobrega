//
//  FooterView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class FooterView: UIView {
  @IBOutlet weak var footerCollectionView: UICollectionView!

  override func awakeFromNib() {
    super.awakeFromNib()
    footerCollectionView.delegate = self
    footerCollectionView.dataSource = self
    footerCollectionView.showsVerticalScrollIndicator = false
    footerCollectionView.showsHorizontalScrollIndicator = false
  }
}

extension FooterView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "footerCell", for: indexPath)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.height - 20, height: collectionView.frame.height - 20)
  }
}
