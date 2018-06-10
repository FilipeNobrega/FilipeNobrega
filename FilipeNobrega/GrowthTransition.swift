//
//  GrowthTransition.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import UIKit

enum TransitionType {
  case dismiss
  case present
}

class GrowthTransition: NSObject, UIViewControllerAnimatedTransitioning {
  var startFrame: CGRect = .zero
  var duration = 0.25
  var transitionType: TransitionType = .present

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
      guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
      animatingView = fromView
    }

    let viewCenter = animatingView.center
    animatingView.backgroundColor = .white

    let scaleX = startFrame.size.width / animatingView.frame.size.width
    let scaleY = startFrame.size.height / animatingView.frame.size.height

    if transitionType == .present {
      animatingView.center = CGPoint(x: startFrame.origin.x + startFrame.size.width / 2,
                                     y: startFrame.origin.y + startFrame.size.height / 2)
      animatingView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
      animatingView.alpha = 0
    } else {
      animatingView.alpha = 1
    }
    containerView.addSubview(animatingView)

    UIView.animate(withDuration: duration, animations: {
      if self.transitionType == .present {
        animatingView.transform = CGAffineTransform.identity
        animatingView.alpha = 1
        animatingView.center = viewCenter
      } else {
        animatingView.center = CGPoint(x: self.startFrame.origin.x + self.startFrame.size.width / 2,
                                       y: self.startFrame.origin.y + self.startFrame.size.height / 2)
        animatingView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        animatingView.alpha = 0
      }
    }, completion: { success in
      transitionContext.completeTransition(success)
    })
  }
}
