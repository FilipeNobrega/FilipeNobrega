//
//  GrowthTransition.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import UIKit

class GrowthTransition: NSObject, UIViewControllerAnimatedTransitioning {
  var startFrame: CGRect = .zero
  var duration = 0.3

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView

    guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

    let viewCenter = presentedView.center
    presentedView.backgroundColor = .white

    let scaleX = startFrame.size.width / presentedView.frame.size.width
    let scaleY = startFrame.size.height / presentedView.frame.size.height

    presentedView.center = CGPoint(x: startFrame.origin.x + startFrame.size.width / 2,
                                   y: startFrame.origin.y + startFrame.size.height / 2)
    presentedView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    presentedView.alpha = 0
    containerView.addSubview(presentedView)

    UIView.animate(withDuration: duration, animations: {
      presentedView.transform = CGAffineTransform.identity
      presentedView.alpha = 1
      presentedView.center = viewCenter
    }, completion: { success in
      transitionContext.completeTransition(success)
    })
  }

  func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
    let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
    let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)

    let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
    let size = CGSize(width: offestVector, height: offestVector)

    return CGRect(origin: CGPoint.zero, size: size)

  }
}
