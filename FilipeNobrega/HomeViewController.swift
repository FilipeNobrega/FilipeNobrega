//
//  HomeViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit

final class HomeViewController: UIViewController {

  @IBOutlet weak private var nameLabel: UILabel!
  @IBOutlet weak private var tileSectionView: TileSectionView!
  @IBOutlet weak private var infoSectionView: InfoSectionView!
  @IBOutlet weak private var footerSectionView: FooterSectionView!
  @IBOutlet weak private var touchContractView: UIView!
  @IBOutlet weak private var expandButton: UIButton!
  @IBOutlet weak private var containerView: UIView!

  private var loadingView: SequentialLoadingView?
  private lazy var viewModel = HomeViewModel(layoutRequester: self.requester.asObservable())
  private let requester = PublishSubject<ServiceType>()
  private let disposeBag = DisposeBag()

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
    prepareGestureSubscriptions()

    tileSectionView.presentViewSubject.subscribe(onNext: { [unowned self] viewController in
      self.present(viewController, animated: true, completion: nil)
    }).disposed(by: disposeBag)

    viewModel.layoutDriver.drive(onNext: { [unowned self] layout in
      guard layout != nil else { return }
      self.loadingView?.loadFinished()
      self.loadingView = nil
    }).disposed(by: disposeBag)

    viewModel.errorSubject.subscribe(onNext: { [unowned self] error in
      guard self.loadingView != nil else { return }
      guard error is NetworkErrorResponse else {
        self.presentAlertView(with: error)
        return
      }
      self.presentAlertView(message: "Unable to parse data from the service", allowRetry: false)
    }).disposed(by: disposeBag)

    viewModel.contactInfoExpanded.subscribe(onNext: { [unowned self] error in
      self.showHideInfoSectionView()
    }).disposed(by: disposeBag)

    tileSectionView.bind(viewModel.tileSectionDriver)
    infoSectionView.bind(viewModel.contactInfoSectionDriver)
    footerSectionView.bind(viewModel.footerSectionDriver)

    requester.onNext(.home)
  }

  private func prepareGestureSubscriptions() {
    touchContractView.rx.anyGesture(.tap(), .swipe(.up))
      .when(.recognized)
      .subscribe(onNext: { [unowned self] _ in
        self.viewModel.toggleContactInfoExpansion()
      }).disposed(by: disposeBag)

    expandButton.rx.tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [unowned self] _ in
        self.viewModel.toggleContactInfoExpansion()
      }).disposed(by: disposeBag)

    guard let collectionView = tileSectionView.collectionView else { return }

    viewModel.contactInfoExpanded
      .map { !$0 }
      .bind(to: collectionView.rx.isScrollEnabled)
      .disposed(by: disposeBag)

    collectionView.rx.swipeGesture(.down)
      .when(.recognized)
      .subscribe(onNext: { [unowned self] _ in
        self.viewModel.toggleContactInfoExpansion()
      }).disposed(by: disposeBag)
  }

  private func presentAlertView(with error: Error? = nil, message: String? = nil, allowRetry: Bool = true) {
    let alert = UIAlertController(title: nil, message: message ?? error?.localizedDescription, preferredStyle: .alert)

    let action: UIAlertAction
    if allowRetry {
      action = UIAlertAction(title: "Retry",
                             style: .default) { [weak self] _ in
                              self?.requester.onNext(.home)
      }
    } else {
      action = UIAlertAction(title: "Ok", style: .default)
    }

    alert.addAction(action)

    present(alert, animated: false, completion: nil)
  }

  private func showHideInfoSectionView() {
    let expanded = viewModel.contactInfoExpanded.value
    let expandHeight = infoSectionView.getHeight() + 10

    if expanded {
      expandButton.setImage(UIImage(named: "arrowup"), for: .normal)
    } else {
      expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
    }

    touchContractView.isUserInteractionEnabled = expanded
    infoSectionView.alpha = expanded ? 0.0 : 1.0
    infoSectionView.isHidden = false

    UIView.animate(withDuration: 0.25, animations: {
      self.containerView.transform = expanded ?
        CGAffineTransform.init(translationX: 0, y: expandHeight) :
        CGAffineTransform.identity
      self.infoSectionView.alpha = expanded ? 1.0 : 0.0
    }, completion: { _ in
      self.infoSectionView.isHidden = !expanded
    })
  }
}

