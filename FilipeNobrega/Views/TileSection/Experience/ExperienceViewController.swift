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

final class ExperienceViewController: UIViewController {
  @IBOutlet weak private var headerImageView: UIImageView!
  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var containerView: UIView!

  private let disposeBag = DisposeBag()
  let sections = BehaviorRelay<[CompanySection]>(value: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension

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
    let dataSource = TablewViewDataSource<ExperienceTableViewCell, CompanySection>
      .dataSource()

    sections
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
