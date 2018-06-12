//
//  ExperienceViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class ExperienceViewController: UIViewController {
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }

  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.contentOffset = CGPoint(x: 0, y: self.headerImageView.frame.height)
    UIView.animate(withDuration: 0.25) {
      self.tableView.contentOffset = .zero
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.25) {
      self.tableView.contentOffset = CGPoint(x: 0, y: self.headerImageView.frame.height)
    }
  }
}


extension ExperienceViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "experienceTableViewCell", for: indexPath)
    return cell
  }
}
