//
//  EducationViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class EducationViewController: UIViewController {
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var containerView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
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
}


extension EducationViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "educationTableViewCell", for: indexPath)
    return cell
  }
}
