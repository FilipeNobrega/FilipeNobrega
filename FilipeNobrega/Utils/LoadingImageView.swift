//
//  LoadingImageView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 30/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Lottie
import UIKit

final class LoadingImageView: UIImageView {
  private var animationView = LOTAnimationView(name: "loading")
  override var image: UIImage? {
    didSet {
      if image != nil {
        stopAnimation()
      } else {
        setupAnimation()
      }
    }
  }

  override var bounds: CGRect {
    didSet {
      updateAnimationViewFrame()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setupAnimation()
  }

  private func updateAnimationViewFrame() {
    let length = (bounds.width > bounds.height ? bounds.height : bounds.width) * 2 / 3
    animationView.frame = CGRect(origin: .zero, size: CGSize(width: length, height: length))
    animationView.center = bounds.center
  }

  private func setupAnimation() {
    updateAnimationViewFrame()
    animationView.loopAnimation = true
    addSubview(animationView)
    animationView.play()
  }

  private func stopAnimation() {
    animationView.removeFromSuperview()
    animationView.pause()
  }
}
