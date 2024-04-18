//
//  WTrackerObjcTests.m
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

#import <WoopraSDK/WoopraSDK-Swift.h>
#import <XCTest/XCTest.h>

@interface WTrackerObjcTests : XCTestCase

@end

@implementation WTrackerObjcTests

- (void)testShared {
    // arrange & act
    WTracker *sharedTracker = [WTracker shared];

    // assert
    XCTAssertNotNil(sharedTracker.properties[@"device"]);
    XCTAssertNotNil(sharedTracker.properties[@"os"]);
    XCTAssertNotNil(sharedTracker.properties[@"browser"]);
}

- (void)testInit {
    // arrange & act
    WTracker *tracker = [[WTracker alloc] init];

    // assert
    XCTAssertNil(tracker.domain);
    XCTAssertNotNil(tracker.visitor);
    XCTAssertEqual(tracker.idleTimeout, 60);
    XCTAssertNil(tracker.referer);
}

- (void)testCanTrackEvent {
    // arrange
    WTracker *tracker = [[WTracker alloc] init];
    WEvent *event = [WEvent eventWithName:@""];

    // act & assert
    [tracker trackEvent:event];
}

- (void)testCanTrackEventWithName {
    // arrange
    WTracker *tracker = [[WTracker alloc] init];

    // act & assert
    [tracker trackEventWithNamed:@""];
}

- (void)testCanPush {
    // arrange
    WTracker *tracker = [[WTracker alloc] init];

    // act & assert
    [tracker push];
}

@end
