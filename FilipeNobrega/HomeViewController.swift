//
//  HomeViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {

  @IBOutlet weak private var nameLabel: UILabel!
  @IBOutlet weak private var containerBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak private var containerTopConstraint: NSLayoutConstraint!
  @IBOutlet weak private var TileSectionView: TileSectionView!
  @IBOutlet weak private var InfoSectionView: InfoSectionView!
  @IBOutlet weak private var touchContractView: UIView!
  @IBOutlet weak private var expandButton: UIButton!
  
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
      self.showHideInfoSectionView()
    }).disposed(by: disposeBag)

    expandButton.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoSectionView()
    }).disposed(by: disposeBag)

    TileSectionView.presentViewSubject.subscribe(onNext: { [unowned self] viewController in
      self.present(viewController, animated: true, completion: nil)
    }).disposed(by: disposeBag)
  }

  private func showHideInfoSectionView() {
    if expanded {
      expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
      containerTopConstraint.constant = 20
      containerBottomConstraint.constant = 0
    } else {
      expandButton.setImage(UIImage(named: "arrowup"), for: .normal)
      let expandHeight = InfoSectionView.getHeight() + 10
      containerTopConstraint.constant += expandHeight
      containerBottomConstraint.constant += expandHeight
    }

    expanded = !expanded

    touchContractView.isUserInteractionEnabled = expanded
    InfoSectionView.alpha = expanded ? 0.0 : 1.0
    InfoSectionView.isHidden = false

    UIView.animate(withDuration: 0.25, animations: {
      self.view.layoutIfNeeded()
      self.InfoSectionView.alpha = self.expanded ? 1.0 : 0.0
    }, completion: { _ in
      self.InfoSectionView.isHidden = !self.expanded
    })
  }
}

