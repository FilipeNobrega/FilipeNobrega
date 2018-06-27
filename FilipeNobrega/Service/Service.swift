//
//  Service.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 25/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum ServiceType {
  case json(url: URL)
}

extension ServiceType: TargetType {
  var baseURL: URL {
    switch self {
    case .json(let url):
      return url
    }
  }

  var path: String { return "" }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String : String]? { return nil }
}

struct ServiceAPI {
  let provider = MoyaProvider<ServiceType>()

  func request<T: Decodable>(_ request: ServiceType) -> Single<T?> {
    return provider.rx
      .request(request)
      .map { response -> Data in
        return response.data
      }
      .map { data -> T? in
        return try? JSONDecoder().decode(T.self, from: data)
    }
  }
}
