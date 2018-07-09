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

  init(provider: MoyaProvider<ImageServiceType> = MoyaProvider(stubClosure: MoyaProvider.neverStub, manager: CacheManage.manager),
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

private struct CacheManage {
  static let manager: Manager = {
    let configuration = URLSessionConfiguration.default
    let fiftyMB = 50 * 1024 * 1024
    let twentyMB = 20 * 1024 * 1024
    let cache = URLCache(memoryCapacity: twentyMB, diskCapacity: fiftyMB, diskPath: "FilipeNobregaCache")
    configuration.urlCache = cache
    return Manager(configuration: configuration)
  }()
}
