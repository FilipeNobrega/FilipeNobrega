//
//  Service.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 25/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Moya
import RxSwift

enum ServiceType {
  case home
}

enum NetworkErrorResponse: Error {
  case unableToParseData
}

extension ServiceType: TargetType {
  var baseURL: URL {
    switch self {
    case .home:
      return URL(string: "https://dl.dropboxusercontent.com/s/v9fsww6dgajeul0/mock.json?dl=0")!
    }
  }

  var path: String { return "" }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    switch self {
    case .home:
      return try! Data(contentsOf: Bundle.main.url(forResource: "LayoutSample", withExtension: "json")!)
    }
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String: String]? { return nil }
}

struct ServiceAPI {
  let provider: MoyaProvider<ServiceType>
  let scheduler: SchedulerType

  init(provider: MoyaProvider<ServiceType> = MoyaProvider(stubClosure: MoyaProvider.neverStub),
       scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.provider = provider
    self.scheduler = scheduler
  }

  func request<T: Decodable>(_ request: ServiceType) -> Single<T?> {
    return provider.rx
      .request(request)
      .debug("wololo")
      .observeOn(scheduler)
      .map { response -> Data in
        return response.data
      }
      .map { data -> T? in
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
          throw NetworkErrorResponse.unableToParseData
        }
        return response
    }
  }
}
