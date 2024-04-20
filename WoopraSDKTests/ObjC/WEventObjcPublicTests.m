//
//  WEventObjcTests.m
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

#import <WoopraSDK/WoopraSDK-Swift.h>
#import <XCTest/XCTest.h>

@interface WEventObjcPublicTests : XCTestCase

@end

@implementation WEventObjcPublicTests

- (void)testInit {
    // arrange & act
    WEvent *event = [[WEvent alloc] initWithName:@"test"];

    // assert
    XCTAssertTrue([event.properties isEqualToDictionary:@{@"~event": @"test"}]);
}

- (void)testStaticInit {
    // arrange & act
    WEvent *event = [WEvent eventWithName:@"test"];

    // assert
    XCTAssertTrue([event.properties isEqualToDictionary:@{@"~event": @"test"}]);
}

@end
