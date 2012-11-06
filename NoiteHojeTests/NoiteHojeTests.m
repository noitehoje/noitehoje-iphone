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
    NSConditionLock *lock = [NSConditionLock new];
    __block BOOL callbackInvoked = NO;
    
    APIWrapper *apiWrapper = [[APIWrapper alloc] init];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Starting...");
        [apiWrapper requestWithCallback:^(NSArray *events) {
            NSLog(@"callback invoked");
            callbackInvoked = YES;
            STAssertTrue(events.count > 0, @"API Wrapper should return events");
            [lock unlockWithCondition:1];
        }];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            NSLog(@"done");
        });
    });
    
    [lock lockWhenCondition:1];
    
    STAssertTrue(callbackInvoked, @"API Callback should be invoked");
}

@end
