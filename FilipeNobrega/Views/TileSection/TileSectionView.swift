//
//  TileSectionView.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 09/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class TileSectionView: UIView {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak private var pageControl: UIPageControl!

  private weak var selectedCell: UICollectionViewCell? {
    didSet {
      cellCenter = selectedCell?.center
      guard let superviewFrame = superview?.frame,
        let cellFrame = selectedCell?.frame else { return }

      let originY = superviewFrame.origin.y + cellFrame.origin.y
      let originX = cellFrame.origin.x - collectionView.contentOffset.x
      cellAbsoluteFrame = CGRect(origin: CGPoint(x: originX, y: originY),
                                 size: cellFrame.size)
    }
  }
  private var cellCenter: CGPoint?
  private var cellAbsoluteFrame: CGRect?

  private var scrollVelocity: CGFloat?
  private let disposeBag = DisposeBag()

  let presentViewSubject = PublishSubject<UIViewController>()

  override func awakeFromNib() {
    super.awakeFromNib()

    collectionView.delegate = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    pageControl.isUserInteractionEnabled = false
    pageControl.numberOfPages = 0

    collectionView.register(StoryboardUtils.nib(for: .freeTextCollectionViewCell),
                            forCellWithReuseIdentifier: TileType.freeText.rawValue)
    collectionView.register(StoryboardUtils.nib(for: .educationCollectionViewCell),
                            forCellWithReuseIdentifier: TileType.education.rawValue)
    collectionView.register(StoryboardUtils.nib(for: .experienceCollectionViewCell),
                            forCellWithReuseIdentifier: TileType.experience.rawValue)
    prepareBinds()
  }

  func bind(_ driver: Driver<[TileSection]>) {
    let dataSource = TileSectionView.dataSource()

    driver
      .do(onNext: { [unowned self] sections in
        self.pageControl.numberOfPages = sections.first?.items.count ?? 0
      })
      .drive(collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }

  private func prepareBinds() {
    collectionView.rx.modelSelected(Tile.self).subscribe(onNext: { [unowned self] tile in
      guard let viewController = StoryboardUtils.viewController(for: tile.type) else { return }
      if let controller = viewController as? TilableViewProtocol {
        controller.prepare(with: tile)
      }
      let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
      self.selectedCell = self.collectionView.cellForItem(at: indexPath)
      viewController.transitioningDelegate = self
      self.presentViewSubject.onNext(viewController)
    }).disposed(by: disposeBag)
  }
}

private extension TileSectionView {
  static func dataSource() -> RxCollectionViewSectionedReloadDataSource<TileSection> {
    return RxCollectionViewSectionedReloadDataSource<TileSection>(configureCell: {
      (dataSource, collection, indexPath, item) -> UICollectionViewCell in
      let cell =
        collection.dequeueReusableCell(withReuseIdentifier: item.identifier,
                                       for: indexPath)
      if let cell = cell as? TilableViewProtocol {
        cell.prepare(with: item)
      }
      return cell
    })
  }
}

extension TileSectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
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

  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
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

// MARK: - UIViewControllerTransitioningDelegate
extension TileSectionView: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let cell = selectedCell,
      let cellCenter = cellCenter,
      let cellAbsoluteFrame = cellAbsoluteFrame else { return nil }

    let transition = GrowthTransition(cell: cell,
                                      cellRelativeCenter: cellCenter,
                                      cellAbsoluteFrame: cellAbsoluteFrame,
                                      duration: 0.4,
                                      transitionType: .present)
    return transition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let cell = selectedCell,
      let cellCenter = cellCenter,
      let cellAbsoluteFrame = cellAbsoluteFrame else { return nil }

    let transition = GrowthTransition(cell: cell,
                                      cellRelativeCenter: cellCenter,
                                      cellAbsoluteFrame: cellAbsoluteFrame,
                                      duration: 0.4,
                                      transitionType: .dismiss)
    return transition
  }
}

