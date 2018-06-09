//
//  ViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var infoView: InfoView!
  @IBOutlet weak var touchContractView: UIView!
  @IBOutlet weak var expandButton: UIButton!

  fileprivate var expanded = false
  fileprivate let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    let tapGesture = UITapGestureRecognizer()
    touchContractView.addGestureRecognizer(tapGesture)

    tapGesture.rx.event.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)

    expandButton.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)
  }

  func showHideInfoView() {
    if expanded {
      containerTopConstraint.constant = 20
      containerBottomConstraint.constant = 0
    } else {
      let expandHeight = infoView.getHeight()
      containerTopConstraint.constant += expandHeight
      containerBottomConstraint.constant += expandHeight
    }
    expanded = !expanded

    touchContractView.isUserInteractionEnabled = expanded

    UIView.animate(withDuration: 0.25, animations: {
      self.view.layoutIfNeeded()
      self.infoView.isHidden = !self.expanded
    })
  }
}
