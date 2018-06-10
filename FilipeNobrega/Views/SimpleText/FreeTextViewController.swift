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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
     self.scrollView.contentOffset = CGPoint(x: 0, y: self.headerImageView.frame.height)
    UIView.animate(withDuration: 0.25) {
      self.scrollView.contentOffset = .zero
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.25) {
      self.scrollView.contentOffset = CGPoint(x: 0, y: self.headerImageView.frame.height)
    }
  }
}
