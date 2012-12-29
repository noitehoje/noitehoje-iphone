//
//  EventList.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIWrapper.h"

@class PagedEvents;

typedef void (^ApiCallback)(PagedEvents *);

@interface PagedEvents : NSObject
{
    APIWrapper *_apiWrapper;
}

@property (nonatomic, assign) NSUInteger totalPages;
@property (nonatomic, assign) NSUInteger totalEvents;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, retain) NSArray *events;
@property (nonatomic, retain) NSString *city;

+ (PagedEvents *)firstPage:(ApiCallback)callback;
+ (PagedEvents *)firstPage:(ApiCallback)callback andCity:(NSString *)city;
- (PagedEvents *)nextPage:(ApiCallback)callback;
- (PagedEvents *)previousPage:(ApiCallback)callback;
- (PagedEvents *)getPage:(NSUInteger)page callback:(ApiCallback)callback;
- (BOOL)isLastPage;

@end
