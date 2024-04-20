//
//  WEventTests.swift
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

import WoopraSDK
import XCTest

final class WEventPublicTests: XCTestCase {

    func testInit() throws {
        // arrange & act
        let event = WEvent(name: "test")

        // assert
        XCTAssertEqual(event.properties as NSDictionary, ["~event": "test"] as NSDictionary)
    }

    func testStaticInit() throws {
        // arrange & act
        let event = WEvent.event(name: "test")

        // assert
        XCTAssertEqual(event.properties as NSDictionary, ["~event": "test"] as NSDictionary)
    }
}
