//
//  HomeViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeViewController: UIViewController {

  @IBOutlet weak private var nameLabel: UILabel!
  @IBOutlet weak private var containerBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak private var containerTopConstraint: NSLayoutConstraint!
  @IBOutlet weak private var tileSectionView: TileSectionView!
  @IBOutlet weak private var infoSectionView: InfoSectionView!
  @IBOutlet weak private var footerSectionView: FooterSectionView!
  @IBOutlet weak private var touchContractView: UIView!
  @IBOutlet weak private var expandButton: UIButton!

  private var loadingView: SequentialLoadingView?
  private lazy var viewModel = HomeViewModel(layoutRequester: self.requester.asObservable())
  private let requester = PublishSubject<ServiceType>()
  private let disposeBag = DisposeBag()
  private var expanded = false

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSubscriptions()
    prepareView()
  }

  private func prepareView() {
    prepareLoadingView()
    view.backgroundColor = StyleGuides.primaryColor
    nameLabel.textColor = StyleGuides.secundaryColor
    expandButton.tintColor = StyleGuides.secundaryColor
  }

  private func prepareLoadingView() {
    let loadingView = SequentialLoadingView()
    self.loadingView = loadingView

    loadingView.frame = view.frame
    loadingView.backgroundColor = StyleGuides.primaryColor
    view.addSubview(loadingView)
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

    tileSectionView.presentViewSubject.subscribe(onNext: { [unowned self] viewController in
      self.present(viewController, animated: true, completion: nil)
    }).disposed(by: disposeBag)

    viewModel.layoutDriver.drive(onNext: { [unowned self] layout in
      guard layout != nil else { return }
      self.loadingView?.loadFinished()
    }).disposed(by: disposeBag)
    tileSectionView.prepareBind(viewModel.tileSectionDriver)
    infoSectionView.prepareBind(viewModel.contactInfoSectionDriver)
    footerSectionView.prepareBind(viewModel.footerSectionDriver)

    requester.onNext(.home)
  }

  private func showHideInfoSectionView() {
    if expanded {
      expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
      containerTopConstraint.constant = 20
      containerBottomConstraint.constant = 0
    } else {
      expandButton.setImage(UIImage(named: "arrowup"), for: .normal)
      let expandHeight = infoSectionView.getHeight() + 10
      containerTopConstraint.constant += expandHeight
      containerBottomConstraint.constant += expandHeight
    }

    expanded = !expanded

    touchContractView.isUserInteractionEnabled = expanded
    infoSectionView.alpha = expanded ? 0.0 : 1.0
    infoSectionView.isHidden = false

    UIView.animate(withDuration: 0.25, animations: {
      self.view.layoutIfNeeded()
      self.infoSectionView.alpha = self.expanded ? 1.0 : 0.0
    }, completion: { _ in
      self.infoSectionView.isHidden = !self.expanded
    })
  }
}

