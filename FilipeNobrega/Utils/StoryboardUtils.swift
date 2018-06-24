//
//  StoryboardUtils.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 10/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import UIKit

enum FilipeNib: String {
  case freeTextCollectionViewCell = "FreeTextCollectionViewCell"
  case educationCollectionViewCell = "EducationCollectionViewCell"
  case experienceCollectionViewCell = "ExperienceCollectionViewCell"
}

struct StoryboardUtils {
  static func nib(for identifier: FilipeNib) -> UINib {
    return UINib(nibName: identifier.rawValue, bundle: nil)
  }

  static func viewController(for identifier: TileType) -> UIViewController? {
    let storyboard = UIStoryboard(name: identifier.rawValue, bundle: nil)
    return storyboard.instantiateInitialViewController()
  }
}
