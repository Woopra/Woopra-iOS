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

    override func tearDown() async throws {
        try await super.tearDown()
        // do necessary reset for WTracker.shared here
    }

    func testSharedBasicProperties() throws {
        // arrange & act
        let sharedTracker = WTracker.shared

        // assert
        XCTAssertNotNil(sharedTracker.properties["device"])
        XCTAssertNotNil(sharedTracker.properties["os"])
        XCTAssertNotNil(sharedTracker.properties["browser"])
    }

    func testCanTrackEvent() throws {
        // arrange
        let tracker = WTracker.shared
        let event = WEvent(name: "")

        // act & assert
        tracker.trackEvent(event)
    }

    func testCanTrackEventWithName() throws {
        // arrange
        let tracker = WTracker.shared

        // act & assert
        tracker.trackEvent(named: "")
    }

    func testCanPush() throws {
        // arrange
        let tracker = WTracker.shared

        // act & assert
        tracker.push()
    }
}
