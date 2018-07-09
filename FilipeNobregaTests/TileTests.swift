//
//  TileTests.swift
//  FilipeNobregaTests
//
//  Created by Filipe Nobrega on 23/06/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import XCTest
@testable import FilipeNobrega

final class TileTests: XCTestCase {
  func testTileWillThrowErrorWhenJsonIsEmpty() {
    let tileJSONString = "{}"
    XCTAssertThrowsError(try JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)) { error in
      XCTAssertEqual(error as! TileError, TileError.unhandled)
    }
  }

  func testTileWillThrowIfTypeIsIncorrect() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"randomType\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
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
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile.tile)
    XCTAssert(tile.tile is FreeTextTile)
    XCTAssertEqual(tile.tile?.identifier, "FreeText")
  }

  func testTileWillReturnEducationTile() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile.tile)
    XCTAssert(tile.tile is EducationTile)
    XCTAssertEqual(tile.tile?.identifier, "Education")
  }

  func testTileWillReturnExperienceTile() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!)

    XCTAssertNotNil(tile.tile)
    XCTAssert(tile.tile is ExperienceTile)
    XCTAssertEqual(tile.tile?.identifier, "Experience")
  }

  // MARK: - Equals

  func testEqualFreeTextTilesAreEqual() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! FreeTextTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! FreeTextTile

    XCTAssertEqual(tile, tile2)
  }

  func testEqualEducationTilesAreEqual() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! EducationTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! EducationTile

    XCTAssertEqual(tile, tile2)
  }

  func testEqualExperienceTilesAreEqual() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! ExperienceTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! ExperienceTile

    XCTAssertEqual(tile, tile2)
  }

  func testFreeTextTileWithDifferenciesTilesAreDifferent() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! FreeTextTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! FreeTextTile

    let tileJSONString3 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription2\" }"
    let tile3 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString3.data(using: .utf8)!).tile as! FreeTextTile

    let tileJSONString4 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"FreeText\", \"headerImage\": \"image2\", \"longDescription\": \"longDescription2\" }"
    let tile4 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString4.data(using: .utf8)!).tile as! FreeTextTile

    XCTAssertNotEqual(tile, tile2)
    XCTAssertNotEqual(tile2, tile3)
    XCTAssertNotEqual(tile3, tile4)
  }

  func testEducationTileWithDifferenciesTilesAreDifferent() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! EducationTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! EducationTile

    let tileJSONString3 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [{  \"image\": \"URL\", \"title\": \"title\", \"major\": \"major\"}] }"
    let tile3 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString3.data(using: .utf8)!).tile as! EducationTile

    XCTAssertNotEqual(tile, tile2)
    XCTAssertNotEqual(tile2, tile3)
  }

  func testExperienceTileWithDifferenciesTilesAreDifferent() {
    let tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let tile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! ExperienceTile

    let tileJSONString2 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let tile2 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString2.data(using: .utf8)!).tile as! ExperienceTile

    let tileJSONString3 = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [{ \"image\": \"URL\", \"title\": \"title\", \"subtitle\": \"subtitle\", \"description\": \"description\"}] }"
    let tile3 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString3.data(using: .utf8)!).tile as! ExperienceTile

    let tileJSONString4 = "{ \"title\": \"title2\" ,\"shortDescription\": \"shortDescription2\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [{ \"image\": \"URL\", \"title\": \"title\", \"subtitle\": \"subtitle\", \"description\": \"description\"}] }"
    let tile4 = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString4.data(using: .utf8)!).tile as! ExperienceTile

    XCTAssertNotEqual(tile, tile2)
    XCTAssertNotEqual(tile2, tile3)
    XCTAssertNotEqual(tile3, tile4)
  }

  func testEqualArrayOfTilesAreEquals() {
    var tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let freeTextTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! FreeTextTile

    tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let educationTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! EducationTile

    tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let experienceTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! ExperienceTile

    let tilesArray: [Tile] = [freeTextTile, educationTile, experienceTile]
    let tilesArray2: [Tile] = [freeTextTile, educationTile, experienceTile]

    XCTAssertEqual(tilesArray.map { AnyTile($0) }, tilesArray2.map { AnyTile($0) })
  }

  func testArrayOfTilesWithSameElementsButDifferentOrderAreDifferent() {
    var tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let freeTextTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! FreeTextTile

    tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let educationTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! EducationTile

    tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Experience\", \"headerImage\": \"image\", \"companies\": [] }"
    let experienceTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! ExperienceTile

    let tilesArray: [Tile] = [freeTextTile, experienceTile, educationTile]
    let tilesArray2: [Tile] = [freeTextTile, educationTile, experienceTile]

    XCTAssertNotEqual(tilesArray.map { AnyTile($0) }, tilesArray2.map { AnyTile($0) })
  }

  func testDifferentArrayOfTilesAreDifferent() {
    var tileJSONString = "{ \"title\": \"title\" ,\"shortDescription\": \"shortDescription\", \"type\": \"FreeText\", \"headerImage\": \"image\", \"longDescription\": \"longDescription\" }"
    let freeTextTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! FreeTextTile

    tileJSONString = "{ \"title\": \"title2\" ,\"shortDescription\": \"shortDescription\", \"type\": \"Education\", \"headerImage\": \"image\", \"colleges\": [] }"
    let educationTile = try! JSONDecoder().decode(FailableTile.self, from: tileJSONString.data(using: .utf8)!).tile as! EducationTile

    let tilesArray: [Tile] = [educationTile]
    let tilesArray2: [Tile] = [freeTextTile]

    XCTAssertNotEqual(tilesArray.map { AnyTile($0) }, tilesArray2.map { AnyTile($0) })
  }
}
