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

  private let service = ServiceAPI()

  let layoutDriver: Driver<Layout?>
  let tileSectionDriver: Driver<[TileSection]>
  let footerSectionDriver: Driver<[FooterSection]>
  let contactInfoSectionDriver: Driver<[ContactInfo]>

  init(layoutRequester: Observable<URL>) {
    let drivers = HomeViewModel.createDrivers(request: layoutRequester,
                                              service: service)

    layoutDriver = drivers.layout
    tileSectionDriver = drivers.tile
    footerSectionDriver = drivers.footer
    contactInfoSectionDriver = drivers.contactInfo
  }

  private static func createDrivers(request: Observable<URL>,
                                    service: ServiceAPI) -> Drivers {

      let tileSectionRelay = BehaviorRelay<[TileSection]>(value: [])
      let footerSectionRelay = BehaviorRelay<[FooterSection]>(value: [])
      let contactInfoRelay = BehaviorRelay<[ContactInfo]>(value: [])

      let layoutDriver = request
        .distinctUntilChanged()
        .flatMapLatest {
          return service.request(.json(url: $0)) as Single<Layout?>
        }
        .asDriver { (error) -> SharedSequence<DriverSharingStrategy, Layout?> in
          print("Unexpected error: \(error.localizedDescription)")
          return Driver.just(nil)
        }
        .do(onNext: { layout in
          guard let layout = layout else { return }
          tileSectionRelay.accept([layout.tileSection])
          footerSectionRelay.accept([layout.footerSection])
          contactInfoRelay.accept([layout.contactInfo])
        })

      let tileSectionDriver = tileSectionRelay.asDriver()
      let footerSectionDriver = footerSectionRelay.asDriver()
      let contactInfoDriver = contactInfoRelay.asDriver()

      return (layoutDriver, tileSectionDriver, footerSectionDriver, contactInfoDriver)
  }
}
