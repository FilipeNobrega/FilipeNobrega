//
//  InfoSectionView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

final class InfoSectionView: UIView {
  @IBOutlet weak private var infoTableView: UITableView!
  @IBOutlet weak private var avatarImageView: UIImageView!
  @IBOutlet weak private var topSeparatorView: UIView!

  private let disposeBag = DisposeBag()

  override func awakeFromNib() {
    super.awakeFromNib()
    infoTableView.showsVerticalScrollIndicator = false
    infoTableView.showsHorizontalScrollIndicator = false
    infoTableView.isUserInteractionEnabled = false
    avatarImageView.rounded()
    topSeparatorView.backgroundColor = StyleGuides.secundaryColor
    topSeparatorView.alpha = StyleGuides.tableViewSeparatorAlpha

    prepareBinds()
  }

  public func getHeight() -> CGFloat {
    return infoTableView.contentSize.height + infoTableView.frame.origin.y
  }

  private func prepareBinds() {
    let sections = ContactInfo.mockInfo()

    let dataSource = InfoSectionView.dataSource()

    Observable.just(sections)
      .bind(to: infoTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}

private extension InfoSectionView {
  static func dataSource() -> RxTableViewSectionedReloadDataSource<ContactInfo> {
    return RxTableViewSectionedReloadDataSource<ContactInfo>(configureCell:
      { (dataSource, tableView, indexPath, contactField) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        if let cell = cell as? ContactCell {
          cell.prepare(with: contactField)
        }
        return cell
    })
  }
}
