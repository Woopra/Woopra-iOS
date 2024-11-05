//
//  WTrackerTests.swift
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/19.
//  Copyright © 2024 Woopra. All rights reserved.
//

@testable import WoopraSDK
import XCTest

final class WTrackerTests: XCTestCase {

    func testInit() throws {
        // arrange & act
        let tracker = WTracker()

        // assert
        XCTAssertNil(tracker.domain)
        XCTAssertNotNil(tracker.visitor)
        XCTAssertEqual(tracker.idleTimeout, 300)
        XCTAssertNil(tracker.referer)
    }
}
