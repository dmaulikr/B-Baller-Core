//
//  B_Baller_CoreTests.m
//  B-Baller CoreTests
//
//  Created by MMTWR on 7/7/14.
//  Copyright (c) 2014 Big Head Apps. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface B_Baller_CoreTests : XCTestCase

@end

@implementation B_Baller_CoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end