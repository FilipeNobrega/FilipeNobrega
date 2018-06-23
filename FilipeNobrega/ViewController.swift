//
//  ViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxSwift

final class ViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var mainView: MainView!
  @IBOutlet weak var infoView: InfoView!
  @IBOutlet weak var touchContractView: UIView!
  @IBOutlet weak var expandButton: UIButton!
  
  private let disposeBag = DisposeBag()

  private var expanded = false

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSubscriptions()
    prepareView()
  }

  private func prepareView() {
    view.backgroundColor = StyleGuides.primaryColor
    nameLabel.textColor = StyleGuides.secundaryColor
    expandButton.tintColor = StyleGuides.secundaryColor
  }

  private func prepareSubscriptions() {
    let tapGesture = UITapGestureRecognizer()
    touchContractView.addGestureRecognizer(tapGesture)

    tapGesture.rx.event.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)

    expandButton.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)

    mainView.presentViewSubject.subscribe(onNext: { [unowned self] viewController in
      self.present(viewController, animated: true, completion: nil)
    }).disposed(by: disposeBag)
  }

  private func showHideInfoView() {
    if expanded {
      expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
      containerTopConstraint.constant = 20
      containerBottomConstraint.constant = 0
    } else {
      expandButton.setImage(UIImage(named: "arrowup"), for: .normal)
      let expandHeight = infoView.getHeight() + 10
      containerTopConstraint.constant += expandHeight
      containerBottomConstraint.constant += expandHeight
    }

    expanded = !expanded

    touchContractView.isUserInteractionEnabled = expanded
    infoView.alpha = expanded ? 0.0 : 1.0
    infoView.isHidden = false

    UIView.animate(withDuration: 0.25, animations: {
      self.view.layoutIfNeeded()
      self.infoView.alpha = self.expanded ? 1.0 : 0.0
    }, completion: { _ in
      self.infoView.isHidden = !self.expanded
    })
  }
}

