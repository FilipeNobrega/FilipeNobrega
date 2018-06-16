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
  fileprivate var cell: UICollectionViewCell? {
    didSet {
      cellCenter = cell?.center
    }
  }
  fileprivate var cellCenter: CGPoint?

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
      let viewController: UIViewController
      self.cell = self.mainView.collectionView.cellForItem(at: indexPath)
      if indexPath.row % 3 == 0 {
        guard let vc = StoryboardUtils.viewController(for: .freeText) else { return }
        viewController = vc
      } else if indexPath.row % 3 == 1 {
        guard let vc = StoryboardUtils.viewController(for: .education) else { return }
        viewController = vc
      } else {
        guard let vc = StoryboardUtils.viewController(for: .experience) else { return }
        viewController = vc
      }
      viewController.transitioningDelegate = self
      self.present(viewController, animated: true, completion: nil)
    }).disposed(by: disposeBag)
  }

  func showHideInfoView() {
    if expanded {
      containerTopConstraint.constant = 20
      containerBottomConstraint.constant = 0
    } else {
      let expandHeight = infoView.getHeight() + 10
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
    let frame = mainView.collectionView.frame
    guard let cell = cell, let cellCenter = cellCenter else { return nil }
    let cellAbsoluteFrame = CGRect(origin: CGPoint(x: 20, y: infoView.frame.origin.y),
                                   size: CGSize(width: frame.width - 40, height: frame.height))
    let transition = GrowthTransition(cell: cell,
                                      cellRelativeCenter: cellCenter,
                                      cellAbsoluteFrame: cellAbsoluteFrame,
                                      duration: 0.4,
                                      transitionType: .present)
    return transition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let frame = mainView.collectionView.frame
    guard let cell = cell, let cellCenter = cellCenter else { return nil }
    let cellAbsoluteFrame = CGRect(origin: CGPoint(x: 20, y: infoView.frame.origin.y),
                                   size: CGSize(width: frame.width - 40, height: frame.height))
    let transition = GrowthTransition(cell: cell,
                                      cellRelativeCenter: cellCenter,
                                      cellAbsoluteFrame: cellAbsoluteFrame,
                                      duration: 0.4,
                                      transitionType: .dismiss)
    return transition
  }
}
