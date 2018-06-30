//
//  FreeTextViewController.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class FreeTextViewController: UIViewController, TilableViewProtocol {
  @IBOutlet weak private var headerImageView: LoadingImageView!
  @IBOutlet weak private var longDescriptionLabel: UILabel!

  private let disposeBag = DisposeBag()
  private var image: Single<UIImage?>?
  private var longDescription: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    prepareBinds()
  }

  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  private func prepareBinds() {
    image?
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .asDriver(onErrorDriveWith: Driver.empty())
      .drive(onNext: { [unowned self] image in
        self.headerImageView.image = image
      }).disposed(by: disposeBag)
  }

  func prepare(with tile: Tile) {
    guard let tile = tile as? FreeTextTile else { return }
    self.longDescription = tile.longDescription ?? tile.shortDescription
    self.image = ImageServiceAPI.image(from: tile.headerImage)
  }
}
