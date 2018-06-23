//
//  TileTests.swift
//  FilipeNobregaTests
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import XCTest
@testable import FilipeNobrega

class TileTests: XCTestCase {
  func testTileWillThrowErrorWhenJsonIsEmpty() {
    let tileJSONString = "{}"
    XCTAssertThrowsError(try JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)) { error in
      XCTAssertEqual(error as! TileError, TileError.unhandled)
    }
  }
}
