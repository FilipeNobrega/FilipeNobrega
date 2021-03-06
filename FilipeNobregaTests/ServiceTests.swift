//
//  ServiceTests.swift
//  FilipeNobregaTests
//
//  Created by Filipe Nobrega on 08/07/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import XCTest
@testable import FilipeNobrega
import Moya
import RxSwift
import RxTest

final class ServiceTests: XCTestCase {
  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!

  override func setUp() {
    super.setUp()
    self.disposeBag = DisposeBag()
    self.scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
  }

  func testLayoutSampleDataCorrectNumberOfItems() {
    let events = self.simulatedLayoutEvents().map {
      Recorded<Event<[Int]>>(time: $0.time, value: $0.value.map { [$0.tileSection.items.count, $0.contactInfo.fields.count, $0.footerSection.items.count] })
    }

    let expected = [
      Recorded.next(0, [3,4,5]),
      Recorded.completed(0)
    ]

    XCTAssertEqual(events, expected)
  }

  func testImageSampleData() {
    let events = self.simulatedImageEvents(url: URL(string: "www.stubed.com")!).map {
      Recorded<Event<[Int]>>(time: $0.time, value: $0.value.map { [Int($0.size.height), Int($0.size.width)] })
    }

    let expected = [
      Recorded.next(0, [200,200]),
      Recorded.completed(0)
    ]

    XCTAssertEqual(events, expected)
  }

  // MARK: - Test helpers
  private func simulatedLayoutEvents(stubClosure: @escaping ((ServiceType) -> Moya.StubBehavior) = MoyaProvider.immediatelyStub) -> [Recorded<Event<Layout>>] {
    let service = ServiceAPI(provider: MoyaProvider<ServiceType>(stubClosure: stubClosure),
                             scheduler: scheduler)
    let results = scheduler.createObserver(Layout.self)

    scheduler.scheduleAt(0) {
      service.request(.home).asObservable().map { $0! }
        .subscribe(results).disposed(by: self.disposeBag)
    }
    scheduler.start()

    return results.events
  }

  private func simulatedImageEvents(url: URL,
                                    stubClosure: @escaping ((ImageServiceType) -> Moya.StubBehavior) = MoyaProvider.immediatelyStub) -> [Recorded<Event<Image>>] {
    let service = ImageServiceAPI(provider: MoyaProvider<ImageServiceType>(stubClosure: stubClosure),
                                  scheduler: scheduler)
    let results = scheduler.createObserver(Image.self)

    scheduler.scheduleAt(0) {
      service.image(from: url).asObservable().map { $0! }
        .subscribe(results).disposed(by: self.disposeBag)
    }
    scheduler.start()

    return results.events
  }
}
