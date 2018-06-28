//
//  GrowthTransition.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

enum TransitionType {
  case dismiss
  case present
}

final class GrowthTransition: NSObject, UIViewControllerAnimatedTransitioning {
  private var cell: UICollectionViewCell
  private var cellRelativeCenter: CGPoint
  private var cellAbsoluteFrame: CGRect
  private var duration: TimeInterval
  private var transitionType: TransitionType

  @available(*, unavailable)
  override init() {
    fatalError("The designated initializer init(cell:cellRelativeCenter:cellAbsoluteFrame:duration:transitionType:) should be used instead")
  }

  init(cell: UICollectionViewCell,
       cellRelativeCenter: CGPoint,
       cellAbsoluteFrame: CGRect,
       duration: TimeInterval,
       transitionType: TransitionType) {
    self.cell = cell
    self.cellRelativeCenter = cellRelativeCenter
    self.cellAbsoluteFrame = cellAbsoluteFrame
    self.duration = duration
    self.transitionType = transitionType
    super.init()
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView

    let animatingView: UIView

    if transitionType == .present {
      guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
      animatingView = toView
    } else {
      guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
      guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
      containerView.addSubview(toView)
      animatingView = fromView
    }

    let viewCenter = animatingView.center
    animatingView.backgroundColor = .white

    cell.center = cellAbsoluteFrame.center
    let collectionView = cell.superview
    let view: UIView
    if transitionType == .present {
      view = UIView(frame: cell.frame)

      containerView.addSubview(cell)
      containerView.addSubview(view)
      containerView.addSubview(animatingView)

      animatingView.center = cellAbsoluteFrame.center
      animatingView.transformSize(to: cellAbsoluteFrame.size)
      animatingView.alpha = 0
      view.alpha = 0
    } else {
      view = UIView(frame: animatingView.frame)

      containerView.addSubview(animatingView)
      containerView.addSubview(view)
      containerView.addSubview(cell)

      view.alpha = 0
      cell.alpha = 0
      animatingView.alpha = 1
    }
    view.backgroundColor = .white

    UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                            delay: 0,
                            options: [.calculationModeLinear],
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4, animations: {
                                view.alpha = 1
                              })
                              UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                                if self.transitionType == .present {
                                  animatingView.transform = CGAffineTransform.identity
                                  self.cell.transformSize(to: animatingView.frame.size)
                                  view.transformSize(to: animatingView.frame.size)

                                  animatingView.center = viewCenter
                                  self.cell.center = viewCenter
                                  view.center = viewCenter
                                } else {
                                  animatingView.transformSize(to: self.cellAbsoluteFrame.size)
                                  view.transformSize(to: self.cellAbsoluteFrame.size)
                                  self.cell.transform = CGAffineTransform.identity
                                  animatingView.center = self.cellAbsoluteFrame.center

                                  view.center = animatingView.center
                                  self.cell.center = animatingView.center
                                  animatingView.alpha = 0
                                }
                              })
                              UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4, animations: {
                                if self.transitionType == .present {
                                  animatingView.alpha = 1
                                } else {
                                  self.cell.alpha = 1
                                }
                              })


    }) { success in
      if self.transitionType == .present {
        animatingView.alpha = 1
      }
      collectionView?.addSubview(self.cell)
      self.cell.center = self.cellRelativeCenter
      transitionContext.completeTransition(success)
    }
  }
}

private extension CGRect {
  var center: CGPoint {
    return CGPoint(x: origin.x + size.width / 2,
                   y: origin.y + size.height / 2)
  }
}

private extension UIView {
  func transformSize(to size: CGSize) {
    let scaleX = size.width / self.frame.size.width
    let scaleY = size.height / self.frame.size.height
    self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
  }
}
