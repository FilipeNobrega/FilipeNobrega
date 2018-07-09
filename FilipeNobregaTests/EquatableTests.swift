//
//  EquatableTests.swift
//  FilipeNobregaTests
//
//  Created by Filipe Nobrega on 08/07/18.
//  Copyright © 2018 Filipe. All rights reserved.
//

import XCTest
@testable import FilipeNobrega

class EquatableTests: XCTestCase {

  func testContactFieldEquatable() {
    let contactField1 = ContactField(icon: URL(string: "www.url1.com")!, text: "field1")
    let contactField2 = ContactField(icon: URL(string: "www.url1.com")!, text: "field2")
    let contactField3 = ContactField(icon: URL(string: "www.url2.com")!, text: "field2")

    XCTAssertNotEqual(contactField1, contactField2)
    XCTAssertNotEqual(contactField3, contactField2)
  }

  func testContactInfoEquatable() {
    let contactField1 = ContactField(icon: URL(string: "www.url1.com")!, text: "field1")
    let contactField2 = ContactField(icon: URL(string: "www.url1.com")!, text: "field2")
    let contactInfo1 = ContactInfo(avatar: URL(string: "www.url1.com")!, fields: [contactField1])
    let contactInfo2 = ContactInfo(avatar: URL(string: "www.url1.com")!, fields: [contactField2])
    let contactInfo3 = ContactInfo(avatar: URL(string: "www.url2.com")!, fields: [contactField2])

    XCTAssertNotEqual(contactInfo1, contactInfo2)
    XCTAssertNotEqual(contactInfo3, contactInfo2)
  }

  func testCollegeEquatable() {
    let college1 = College(image: URL(string: "www.url1.com")!, title: "title1", major: "major1", observation: "obs1")
    let college2 = College(image: URL(string: "www.url2.com")!, title: "title1", major: "major1", observation: "obs1")
    let college3 = College(image: URL(string: "www.url2.com")!, title: "title2", major: "major1", observation: "obs1")
    let college4 = College(image: URL(string: "www.url2.com")!, title: "title2", major: "major2", observation: "obs1")
    let college5 = College(image: URL(string: "www.url2.com")!, title: "title2", major: "major2", observation: "obs2")

    XCTAssertNotEqual(college1, college2)
    XCTAssertNotEqual(college3, college2)
    XCTAssertNotEqual(college4, college3)
    XCTAssertNotEqual(college5, college4)
  }

  func testCompanyEquatable() {
    let company1 = Company(image: URL(string: "www.url1.com")!, title: "title1", subtitle: "subtitle1", description: "description1")
    let company2 = Company(image: URL(string: "www.url2.com")!, title: "title1", subtitle: "subtitle1", description: "description1")
    let company3 = Company(image: URL(string: "www.url2.com")!, title: "title2", subtitle: "subtitle1", description: "description1")
    let company4 = Company(image: URL(string: "www.url2.com")!, title: "title2", subtitle: "subtitle2", description: "description1")
    let company5 = Company(image: URL(string: "www.url2.com")!, title: "title2", subtitle: "subtitle2", description: "description2")

    XCTAssertNotEqual(company1, company2)
    XCTAssertNotEqual(company3, company2)
    XCTAssertNotEqual(company4, company3)
    XCTAssertNotEqual(company5, company4)
  }
}
