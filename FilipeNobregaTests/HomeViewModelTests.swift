//
//  HomeViewModelTests.swift
//  FilipeNobregaTests
//
//  Created by Filipe Nobrega on 08/07/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import XCTest
@testable import FilipeNobrega
import Moya
import RxSwift
import RxCocoa
import RxTest

final class HomeViewModelTests: XCTestCase {
  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!
  var sampleLayout: Layout!

  override func setUp() {
    super.setUp()
    self.disposeBag = DisposeBag()
    self.scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
    let data = try! Data(contentsOf: Bundle.main.url(forResource: "LayoutSample", withExtension: "json")!)
    self.sampleLayout = try! JSONDecoder().decode(Layout.self, from: data)
  }

  func testHomeLayoutRequestsEvent() {
    let requester = scheduler.createHotObservable([
      Recorded.next(1, ServiceType.home)
      ])

    let service = ServiceAPI(provider: MoyaProvider<ServiceType>(stubClosure: MoyaProvider.immediatelyStub),
                             scheduler: scheduler)

    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable(),
                                      service: service)

    let results = scheduler.createObserver(Layout.self)

    scheduler.scheduleAt(0) {
      homeViewModel.layoutDriver.map { $0! }
        .drive(results)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    let expected = [
      Recorded.next(1, self.sampleLayout!)
    ]

    XCTAssertEqual(results.events, expected)
  }

  func testHomeLayoutRequestsWillFireAllDriversEvent() {
    let requester = scheduler.createHotObservable([
      Recorded.next(1, ServiceType.home)
      ])

    let service = ServiceAPI(provider: MoyaProvider<ServiceType>(stubClosure: MoyaProvider.immediatelyStub),
                             scheduler: scheduler)

    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable(),
                                      service: service)

    let tileSectionResults = scheduler.createObserver([TileSection].self)
    let footerSectionResults = scheduler.createObserver([FooterSection].self)
    let contactInfoResults = scheduler.createObserver([ContactInfo].self)

    scheduler.scheduleAt(0) {
      homeViewModel.layoutDriver.drive().disposed(by: self.disposeBag)
      homeViewModel.tileSectionDriver
        .drive(tileSectionResults)
        .disposed(by: self.disposeBag)
      homeViewModel.footerSectionDriver
        .drive(footerSectionResults)
        .disposed(by: self.disposeBag)
      homeViewModel.contactInfoSectionDriver
        .drive(contactInfoResults)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    let tileSectionExpectations = [
      Recorded.next(0, [TileSection]()),
      Recorded.next(1, [self.sampleLayout!.tileSection])
    ]
    let footerSectionExpectations = [
      Recorded.next(0, [FooterSection]()),
      Recorded.next(1, [self.sampleLayout!.footerSection])
    ]
    let contactInfoExpectations = [
      Recorded.next(0, [ContactInfo]()),
      Recorded.next(1, [self.sampleLayout!.contactInfo])
    ]

    XCTAssertEqual(tileSectionResults.events, tileSectionExpectations)
    XCTAssertEqual(footerSectionResults.events, footerSectionExpectations)
    XCTAssertEqual(contactInfoResults.events, contactInfoExpectations)
  }

  func testHomeLayoutTwoEqualRequestsWontFireAllDriversOnSecondRequestEvent() {
    let requester = scheduler.createHotObservable([
      Recorded.next(1, ServiceType.home),
      Recorded.next(5, ServiceType.home)
      ])

    let service = ServiceAPI(provider: MoyaProvider<ServiceType>(stubClosure: MoyaProvider.immediatelyStub),
                             scheduler: scheduler)

    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable(),
                                      service: service)

    let tileSectionResults = scheduler.createObserver([TileSection].self)
    let footerSectionResults = scheduler.createObserver([FooterSection].self)
    let contactInfoResults = scheduler.createObserver([ContactInfo].self)

    scheduler.scheduleAt(0) {
      homeViewModel.layoutDriver.drive().disposed(by: self.disposeBag)
      homeViewModel.tileSectionDriver
        .drive(tileSectionResults)
        .disposed(by: self.disposeBag)
      homeViewModel.footerSectionDriver
        .drive(footerSectionResults)
        .disposed(by: self.disposeBag)
      homeViewModel.contactInfoSectionDriver
        .drive(contactInfoResults)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    let tileSectionExpectations = [
      Recorded.next(0, [TileSection]()),
      Recorded.next(1, [self.sampleLayout!.tileSection])
    ]
    let footerSectionExpectations = [
      Recorded.next(0, [FooterSection]()),
      Recorded.next(1, [self.sampleLayout!.footerSection])
    ]
    let contactInfoExpectations = [
      Recorded.next(0, [ContactInfo]()),
      Recorded.next(1, [self.sampleLayout!.contactInfo])
    ]

    XCTAssertEqual(tileSectionResults.events, tileSectionExpectations)
    XCTAssertEqual(footerSectionResults.events, footerSectionExpectations)
    XCTAssertEqual(contactInfoResults.events, contactInfoExpectations)
  }

  func testToggleContactInfoExpansionEvent() {
    let requester = Observable<ServiceType>.never()
    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable())

    let results = scheduler.createObserver(Bool.self)

    scheduler.scheduleAt(0) {
      homeViewModel.contactInfoExpanded
        .subscribe(results)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    homeViewModel.toggleContactInfoExpansion()
    homeViewModel.toggleContactInfoExpansion()
    homeViewModel.toggleContactInfoExpansion()
    homeViewModel.toggleContactInfoExpansion()

    let expectation = [
      Recorded.next(0, false),
      Recorded.next(0, true),
      Recorded.next(0, false),
      Recorded.next(0, true),
      Recorded.next(0, false)
    ]

    XCTAssertEqual(results.events, expectation)
  }

  func testWhenRequestFailsWillThrowErrorEvent() {
    let requester = scheduler.createHotObservable([
      Recorded.next(1, ServiceType.home)
      ])

    let provider = MoyaProvider<ServiceType>(endpointClosure: { target -> Endpoint in
      return Endpoint(url: "stubbed",
                      sampleResponseClosure: { .networkError(NSError(domain: "TestError",
                                                                     code: 400,
                                                                     userInfo: nil)) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: target.headers)
    }, stubClosure: { _ -> StubBehavior in
      return .immediate
    })

    let service = ServiceAPI(provider: provider,
                             scheduler: scheduler)

    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable(),
                                      service: service)

    let results = scheduler.createObserver(Bool.self)

    scheduler.scheduleAt(0) {
      homeViewModel.layoutDriver
        .drive()
        .disposed(by: self.disposeBag)

      homeViewModel.errorSubject.asObserver()
        .map { _ in true }
        .subscribe(results)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    let expected = [
      Recorded.next(1, true)
    ]

    XCTAssertEqual(results.events, expected)
  }

  func testWillThrowErrorWhenUnableToParseData() {
    let requester = scheduler.createHotObservable([
      Recorded.next(1, ServiceType.home)
      ])

    let provider = MoyaProvider<ServiceType>(endpointClosure: { target -> Endpoint in
      return Endpoint(url: "stubbed",
                      sampleResponseClosure: { .networkResponse(200, Data()) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: target.headers)
    }, stubClosure: { _ -> StubBehavior in
      return .immediate
    })

    let service = ServiceAPI(provider: provider,
                             scheduler: scheduler)

    let homeViewModel = HomeViewModel(layoutRequester: requester.asObservable(),
                                      service: service)

    let results = scheduler.createObserver(NetworkErrorResponse.self)

    scheduler.scheduleAt(0) {
      homeViewModel.layoutDriver
        .drive()
        .disposed(by: self.disposeBag)

      homeViewModel.errorSubject.asObserver()
        .map { $0 as! NetworkErrorResponse }
        .subscribe(results)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    let expected = [
      Recorded.next(1, NetworkErrorResponse.unableToParseData)
    ]

    XCTAssertEqual(results.events, expected)
  }
  
}
