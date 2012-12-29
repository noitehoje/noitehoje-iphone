//
//  APIWrapper.h
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIWrapper : NSObject

@property (nonatomic, copy) NSString *noiteHojeWSURL;
@property (nonatomic, copy) NSString *noiteHojeAPIKey;
@property (nonatomic, copy) NSString *noiteAPIVersion;
@property (nonatomic, copy) NSMutableData *eventData;

- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback;
- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback andPage:(NSUInteger)page;
- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback page:(NSUInteger)page andCity:(NSString *)city;
- (void)citiesWithCallback:(void (^)(NSArray *))callback;

@end
