//
//  WVisitorTests.swift
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

import WoopraSDK
import XCTest

final class WVisitorPublicTests: XCTestCase {

    func testInitWithCookie() throws {
        // arrange & act
        let visitor = WVisitor.visitor(withCookie: "cookie")

        // assert
        XCTAssertEqual(visitor.cookie, "cookie")
        XCTAssertTrue(visitor.properties.isEmpty)
    }

    func testInitWithEmail() throws {
        // arrange & act
        let visitor = WVisitor.visitor(withEmail: "email")

        // assert
        XCTAssertFalse(visitor.cookie.isEmpty)
        XCTAssertEqual(visitor.properties["email"] as? String, "email")
    }

    func testAnonymousVisitor() throws {
        // arrange & act
        let visitor = WVisitor.anonymousVisitor()

        // assert
        XCTAssertFalse(visitor.cookie.isEmpty)
        XCTAssertTrue(visitor.properties.isEmpty)
    }
}
