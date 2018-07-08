//
//  ImageService.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 27/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Moya
import RxSwift

enum ImageServiceType {
  case image(url: URL)
}

extension ImageServiceType: TargetType {
  var baseURL: URL {
    switch self {
    case .image(let url):
      return url
    }
  }

  var path: String { return "" }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return try! Data(contentsOf: Bundle.main.url(forResource: "imagesample", withExtension: "png")!)
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String: String]? { return nil }
}

struct ImageServiceAPI {
  static let shared = ImageServiceAPI()
  let provider: MoyaProvider<ImageServiceType>
  let scheduler: SchedulerType

  init(provider: MoyaProvider<ImageServiceType> = MoyaProvider(stubClosure: MoyaProvider.neverStub),
       scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.provider = provider
    self.scheduler = scheduler
  }

  func image(from url: URL) -> Single<UIImage?> {
    return provider.rx
      .request(.image(url: url))
      .mapImage()
  }
}
