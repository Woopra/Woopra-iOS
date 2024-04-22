//
//  WTrackerObjcTests.m
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

#import <WoopraSDK/WoopraSDK-Swift.h>
#import <XCTest/XCTest.h>

@interface WTrackerObjcPublicTests : XCTestCase

@end

@implementation WTrackerObjcPublicTests

- (void)tearDownWithCompletionHandler:(void (^)(NSError * _Nullable))completion {
    [super tearDownWithCompletionHandler:completion];
    // do necessary reset for WTracker.shared here
}

- (void)testSharedBasicProperties {
    // arrange & act
    WTracker *sharedTracker = [WTracker shared];

    // assert
    XCTAssertNotNil(sharedTracker.properties[@"device"]);
    XCTAssertNotNil(sharedTracker.properties[@"os"]);
    XCTAssertNotNil(sharedTracker.properties[@"browser"]);
}

- (void)testCanTrackEvent {
    // arrange
    WTracker *tracker = [WTracker shared];
    WEvent *event = [WEvent eventWithName:@""];

    // act & assert
    [tracker trackEvent:event];
}

- (void)testCanTrackEventWithName {
    // arrange
    WTracker *tracker = [WTracker shared];

    // act & assert
    [tracker trackEventWithNamed:@""];
}

- (void)testCanPush {
    // arrange
    WTracker *tracker = [WTracker shared];

    // act & assert
    [tracker push];
}

@end
