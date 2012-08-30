//
//  NoiteHojeTests.m
//  NoiteHojeTests
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "NoiteHojeTests.h"
#import "APIWrapper.h"

@implementation NoiteHojeTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAPIWrapperShouldReturnEvents {
    APIWrapper *apiWrapper = [[APIWrapper alloc] init];
    STAssertTrue([[apiWrapper events] count] > 0, @"API Wrapper should return events");
}

@end
