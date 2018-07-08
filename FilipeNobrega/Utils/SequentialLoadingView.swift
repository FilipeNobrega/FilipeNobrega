//
//  SequentialLoadingView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 30/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Lottie
import UIKit

final class SequentialLoadingView: UIView {
  private var animationView = LOTAnimationView(name: "animation")
  private var isLoadingFinished = false
  override var frame: CGRect {
    didSet {
      updateAnimationViewFrame()
    }
  }

  init() {
    super.init(frame: .zero)
    setupAnimation()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAnimation()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func loadFinished() {
    isLoadingFinished = true
  }

  private func updateAnimationViewFrame() {
    let length = (bounds.width > bounds.height ? bounds.height : bounds.width) * 2 / 3
    animationView.frame = CGRect(origin: .zero, size: CGSize(width: length, height: length))
    animationView.center = bounds.center
  }

  private func setupAnimation() {
    updateAnimationViewFrame()
    addSubview(animationView)
    animationView.loopAnimation = false
    startSequence()
  }

  private func startSequence() {
    animationView.play(toProgress: 0.13) { [weak self] _ in
      self?.animationLoop()
    }
  }

  private func animationLoop() {
    animationView.play(fromProgress: 0.13, toProgress: 0.31) { [weak self] _ in
      guard let strongSelf = self else { return }
      if strongSelf.isLoadingFinished {
        strongSelf.endSequence()
      } else {
        strongSelf.animationLoop()
      }
    }
  }

  private func endSequence() {
    animationView.play(fromProgress: 0.88, toProgress: 1) { [weak self] _ in
      UIView.animate(withDuration: 0.25, animations: { [weak self] in
        self?.alpha = 0
      }) { [weak self] _ in
        self?.removeFromSuperview()
      }
    }
  }
}
