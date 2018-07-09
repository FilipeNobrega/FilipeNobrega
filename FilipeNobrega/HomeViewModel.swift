//
//  HomeViewModel.swift
//  FilipeNobrega
//
//  Created by Filipe Nobrega on 26/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import RxSwift
import RxCocoa

struct HomeViewModel {
  typealias Drivers = (layout: Driver<Layout?>,
    tile: Driver<[TileSection]>,
    footer: Driver<[FooterSection]>,
    contactInfo: Driver<[ContactInfo]>)

  private let service: ServiceAPI

  let layoutDriver: Driver<Layout?>
  let tileSectionDriver: Driver<[TileSection]>
  let footerSectionDriver: Driver<[FooterSection]>
  let contactInfoSectionDriver: Driver<[ContactInfo]>
  let errorSubject = PublishSubject<Error>()
  let contactInfoExpanded = BehaviorRelay<Bool>(value: false)

  init(layoutRequester: Observable<ServiceType>,
       service: ServiceAPI = ServiceAPI()) {

    self.service = service

    let drivers = HomeViewModel.createDrivers(request: layoutRequester,
                                              errorSubject: errorSubject,
                                              service: self.service)

    layoutDriver = drivers.layout
    tileSectionDriver = drivers.tile
    footerSectionDriver = drivers.footer
    contactInfoSectionDriver = drivers.contactInfo
  }

  public func toggleContactInfoExpansion() {
    contactInfoExpanded.accept(!contactInfoExpanded.value)
  }

  private static func createDrivers(request: Observable<ServiceType>,
                                    errorSubject: PublishSubject<Error>,
                                    service: ServiceAPI) -> Drivers {

      let tileSectionRelay = BehaviorRelay<[TileSection]>(value: [])
      let footerSectionRelay = BehaviorRelay<[FooterSection]>(value: [])
      let contactInfoRelay = BehaviorRelay<[ContactInfo]>(value: [])

      let layoutDriver = request
        .flatMapLatest {
          return service.request($0)
            .catchError({ error -> Single<Layout?> in
              errorSubject.onNext(error)
              return Single.just(nil)
            })
        }
        .asDriver { (error) -> SharedSequence<DriverSharingStrategy, Layout?> in
          print("Unexpected error: \(error.localizedDescription)")
          return Driver.just(nil)
        }
        .distinctUntilChanged()
        .do(onNext: { layout in
          guard let layout = layout else { return }
          tileSectionRelay.accept([layout.tileSection])
          footerSectionRelay.accept([layout.footerSection])
          contactInfoRelay.accept([layout.contactInfo])
        })

      let tileSectionDriver = tileSectionRelay.asDriver().distinctUntilChanged()
      let footerSectionDriver = footerSectionRelay.asDriver().distinctUntilChanged()
      let contactInfoDriver = contactInfoRelay.asDriver().distinctUntilChanged()

      return (layoutDriver, tileSectionDriver, footerSectionDriver, contactInfoDriver)
  }
}
