//
//  ExperienceViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxDataSources
import RxSwift
import RxCocoa
import UIKit

final class ExperienceViewController: UIViewController, TilableViewProtocol {
  @IBOutlet weak private var headerImageView: LoadingImageView!
  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var titleLabel: UILabel!

  private let disposeBag = DisposeBag()
  private var section: CompanySection?
  private var image: Single<UIImage?>?

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    titleLabel.textColor = StyleGuides.primaryTextColor
    prepareBinds()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    guard let headerView = tableView.tableHeaderView else { return }
    headerView.frame = containerView.frame
    tableView.tableHeaderView = headerView
    tableView.setNeedsLayout()
  }

  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  private func prepareBinds() {
    guard let section = section else { return }
    let dataSource = TablewViewDataSource<ExperienceTableViewCell, CompanySection>
      .dataSource()

    Observable.just([section])
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)

    image?
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [unowned self] image in
        self.headerImageView.image = image
      }).disposed(by: disposeBag)

    titleLabel.text = title
  }

  func prepare(with tile: Tile) {
    guard let tile = tile as? ExperienceTile else { return }
    self.title = tile.title
    let companySection = CompanySection(items: tile.companies)
    self.section = companySection
    self.image = ImageServiceAPI.image(from: tile.headerImage)
  }
}
