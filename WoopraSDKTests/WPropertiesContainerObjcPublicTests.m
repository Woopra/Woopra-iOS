//
//  WPropertiesContainerObjcTests.m
//  WoopraSDKTests
//
//  Created by Machael.Chang on 2024/4/18.
//  Copyright © 2024 Woopra. All rights reserved.
//

#import <WoopraSDK/WoopraSDK-Swift.h>
#import <XCTest/XCTest.h>

@interface WPropertiesContainerObjcPublicTests : XCTestCase

@end

@implementation WPropertiesContainerObjcPublicTests

- (void)testAddProperty {
    // arrange
    WPropertiesContainer *container = [[WPropertiesContainer alloc] init];

    // act
    [container addWithProperty:@"key" value:@"value"];

    // assert
    XCTAssertTrue([container.properties isEqualToDictionary:@{@"key": @"value"}]);
}

- (void)testAddProperties {
    // arrange
    WPropertiesContainer *container = [[WPropertiesContainer alloc] init];

    // act
    [container addWithProperties:@{@"key": @"value"}];

    // assert
    XCTAssertTrue([container.properties isEqualToDictionary:@{@"key": @"value"}]);
}

@end
