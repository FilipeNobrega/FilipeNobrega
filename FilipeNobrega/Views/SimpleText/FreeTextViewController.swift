//
//  FreeTextViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class FreeTextViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var headerImageView: UIImageView!

  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
