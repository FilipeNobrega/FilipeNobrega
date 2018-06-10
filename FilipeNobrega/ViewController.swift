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
  @IBOutlet weak var mainView: MainView!
  @IBOutlet weak var infoView: InfoView!
  @IBOutlet weak var touchContractView: UIView!
  @IBOutlet weak var expandButton: UIButton!

  fileprivate var expanded = false
  fileprivate let disposeBag = DisposeBag()
  var cell: UICollectionViewCell?

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSubscriptions()
  }

  func prepareSubscriptions() {
    let tapGesture = UITapGestureRecognizer()
    touchContractView.addGestureRecognizer(tapGesture)

    tapGesture.rx.event.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)

    expandButton.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.showHideInfoView()
    }).disposed(by: disposeBag)

    mainView.collectionView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
      self.cell = self.mainView.collectionView.cellForItem(at: indexPath)
      guard let vc = StoryboardUtils.viewController(for: .simpleText) as? SimpleTextViewController else { return }
      vc.transitioningDelegate = self
      vc.modalPresentationStyle = .custom
      self.present(vc, animated: true, completion: nil)
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

extension ViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    let rect = CGRect(origin: mainView.frame.origin, size: mainView.collectionView.frame.size)
    guard let frame = cell?.frame else { return nil }
    let transition = GrowthTransition()
    transition.transitionType = .present
    transition.startFrame = CGRect(origin: CGPoint(x: frame.origin.x, y: infoView.frame.origin.y),
                                   size: frame.size)
    return transition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let frame = cell?.frame else { return nil }
    let transition = GrowthTransition()
    transition.transitionType = .dismiss
    transition.startFrame = CGRect(origin: CGPoint(x: frame.origin.x, y: infoView.frame.origin.y),
                                   size: frame.size)
    return transition
  }
}
