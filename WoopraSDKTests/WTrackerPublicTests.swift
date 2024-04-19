//
//  WTrackerTests.swift
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

import WoopraSDK
import XCTest

final class WTrackerPublicTests: XCTestCase {

    func testShared() throws {
        // arrange & act
        let sharedTracker = WTracker.shared

        // assert
        XCTAssertNotNil(sharedTracker.properties["device"])
        XCTAssertNotNil(sharedTracker.properties["os"])
        XCTAssertNotNil(sharedTracker.properties["browser"])
    }

    func testInit() throws {
        // arrange & act
        let tracker = WTracker()

        // assert
        XCTAssertNil(tracker.domain)
        XCTAssertNotNil(tracker.visitor)
        XCTAssertEqual(tracker.idleTimeout, 60)
        XCTAssertNil(tracker.referer)
    }

    func testCanTrackEvent() throws {
        // arrange
        let tracker = WTracker()
        let event = WEvent(name: "")

        // act & assert
        tracker.trackEvent(event)
    }

    func testCanTrackEventWithName() throws {
        // arrange
        let tracker = WTracker()

        // act & assert
        tracker.trackEvent(named: "")
    }

    func testCanPush() throws {
        // arrange
        let tracker = WTracker()

        // act & assert
        tracker.push()
    }
}
