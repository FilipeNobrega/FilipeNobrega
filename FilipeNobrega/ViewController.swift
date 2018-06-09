//
//  ViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!

  fileprivate var scrollVelocity: CGFloat?
  fileprivate let numberOfPages = 5

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false

    pageControl.numberOfPages = numberOfPages
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfPages
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height - 20)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      snapToNearestCell()
    }
  }

  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    guard let scrollVelocity = scrollVelocity else { return }
    if abs(scrollVelocity) < 0.5 {
     snapToNearestCell()
    } else {
      scrollToNextView(velocity: scrollVelocity)
    }
    self.scrollVelocity = nil
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    scrollVelocity = velocity.x
  }

  private func snapToNearestCell() {
    let currentOffset = collectionView.contentOffset.x
    let currentIndex = pageControl.currentPage
    let nextIndex: Int

    let currentPageOffset = collectionView.frame.width * CGFloat(currentIndex)

    if abs(currentOffset - currentPageOffset) > collectionView.frame.width / 2 {
      nextIndex = currentOffset - currentPageOffset > 0 ? currentIndex + 1 : currentIndex - 1
    } else {
      nextIndex = currentIndex
    }

    guard isValidIndex(nextIndex) else {
      scrollToItem(at: currentIndex)
      return
    }
    scrollToItem(at: nextIndex)
  }

  private func scrollToNextView(velocity: CGFloat) {
    let currentIndex = pageControl.currentPage
    let nextIndex = velocity > 0.0 ? currentIndex + 1 : currentIndex - 1

    guard isValidIndex(nextIndex) else {
      scrollToItem(at: currentIndex)
      return
    }
    scrollToItem(at: nextIndex)
  }

  private func isValidIndex(_ index: Int) -> Bool {
    return index >= 0 && index < pageControl.numberOfPages
  }

  private func scrollToItem(at index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    pageControl.currentPage = indexPath.row
  }
}
