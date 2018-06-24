//
//  FreeTextViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

final class FreeTextViewController: UIViewController {
  @IBOutlet weak private var scrollView: UIScrollView!
  @IBOutlet weak private var headerImageView: UIImageView!

  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
