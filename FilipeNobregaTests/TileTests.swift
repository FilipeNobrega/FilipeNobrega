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

  func testTileWillThrowIfTypeIsIncorrect() {
    let tileJSONString = "{ \"shortDescription\": \"shortDescription\", \"type\": \"randomType\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    XCTAssertThrowsError(try JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)) { error in
      XCTAssertEqual(error as! TileError, TileError.unhandled)
    }
  }

  func testTileWillThrowErrorWhenJsonIsInvalid() {
    let tileJSONString = "{\"invalid\": \"value\"}"
    XCTAssertThrowsError(try JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)) { error in
      XCTAssertEqual(error as! TileError, TileError.unhandled)
    }
  }

  func testTileWillReturnFreeTextTile() {
    let tileJSONString = "{ \"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile = try? JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile?.tile)
    XCTAssert(tile?.tile is FreeTextTile)
  }

  func testTileWillReturnEducationTile() {
    let tileJSONString = "{ \"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\" }"
    let tile = try? JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile?.tile)
    XCTAssert(tile?.tile is EducationTile)
  }

  func testTileWillReturnExperienceTile() {
    let tileJSONString = "{ \"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\" }"
    let tile = try? JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile?.tile)
    XCTAssert(tile?.tile is ExperienceTile)
  }
}
