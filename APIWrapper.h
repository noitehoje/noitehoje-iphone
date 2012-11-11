//
//  APIWrapper.h
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ApiCallback)(NSArray *);

@interface APIWrapper : NSObject
{
    ApiCallback _callback;
}

@property (nonatomic, copy) NSString *noiteHojeWSURL;
@property (nonatomic, copy) NSString *noiteHojeAPIKey;
@property (nonatomic, copy) NSString *noiteAPIVersion;
@property (nonatomic, copy) NSMutableData *eventData;

- (void)requestWithCallback:(ApiCallback)callback;

@end
