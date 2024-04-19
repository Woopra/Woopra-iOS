//
//  WPropertiesContainerTests.swift
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

import WoopraSDK
import XCTest

final class WPropertiesContainerPublicTests: XCTestCase {

    func testAddProperty() throws {
        // arrange
        let container = WPropertiesContainer()

        // act
        container.add(property: "key", value: "value")

        // assert
        XCTAssertEqual(container.properties, ["key": "value"])
    }

    func testAddProperties() throws {
        // arrange
        let container = WPropertiesContainer()

        // act
        container.add(properties: ["key": "value"])

        // assert
        XCTAssertEqual(container.properties, ["key": "value"])
    }
}
