//
//  WVisitorObjcTests.m
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

#import <WoopraSDK/WoopraSDK-Swift.h>
#import <XCTest/XCTest.h>

@interface WVisitorObjcPublicTests : XCTestCase

@end

@implementation WVisitorObjcPublicTests

- (void)testInitWithCookie {
    // arrange & act
    WVisitor *visitor = [WVisitor visitorWithCookie:@"cookie"];

    // assert
    XCTAssertEqual(visitor.cookie, @"cookie");
    XCTAssertTrue(visitor.properties.count == 0);
}

- (void)testInitWithEmail {
    // arrange & act
    WVisitor *visitor = [WVisitor visitorWithEmail: @"email"];

    // assert
    XCTAssertTrue(visitor.cookie.length > 0);
    XCTAssertTrue([visitor.properties isEqualToDictionary:@{@"email": @"email"}]);
}

- (void)testAnonymousVisitor {
    // arrange & act
    WVisitor *visitor = [WVisitor anonymousVisitor];

    // assert
    XCTAssertTrue(visitor.cookie.length > 0);
    XCTAssertTrue(visitor.properties.count == 0);
}

@end
