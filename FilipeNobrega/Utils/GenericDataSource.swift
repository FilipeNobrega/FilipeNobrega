//
//  TablewViewDataSource.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 24/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import RxDataSources

class TablewViewDataSource<C: GenericCellType, S: SectionModelType> where C.Item == S.Item {
  static func dataSource() -> RxTableViewSectionedReloadDataSource<S> {
    return RxTableViewSectionedReloadDataSource<S>(configureCell:
      { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier,
                                                 for: indexPath)
        if let cell = cell as? C {
          cell.prepare(with: item)
        }
        return cell
    })
  }
}

class CollectionViewDataSource<C: GenericCellType, S: SectionModelType> where C.Item == S.Item {
  static func dataSource() -> RxCollectionViewSectionedReloadDataSource<S> {
    return RxCollectionViewSectionedReloadDataSource<S>(configureCell: {
      (_, collection, indexPath, item) -> UICollectionViewCell in
      let cell =
        collection.dequeueReusableCell(withReuseIdentifier: item.identifier,
                                       for: indexPath)
      if let cell = cell as? C {
        cell.prepare(with: item)
      }
      return cell
    })
  }
}

protocol GenericCellType {
  associatedtype Item: GenericItemType
  func prepare(with item: Item)
}

protocol GenericItemType {
  var identifier: String { get }
}
