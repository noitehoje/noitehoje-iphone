//
//  APIWrapper.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "APIWrapper.h"
#import "Event.h"
#import "AFJSONRequestOperation.h"

@implementation APIWrapper

- (id)init {
    self = [super init];
    if (self) {
        self.noiteHojeWSURL = @"http://noitehoje.com.br/api";
        self.noiteAPIVersion = @"v1";
        self.noiteHojeAPIKey = @"crEjew8r";
    }
    return self;
}

- (void)requestWithCallback:(ApiCallback)callback
{
    [self requestWithCallback:callback andPage:1];
}

- (void)requestWithCallback:(ApiCallback)callback andPage:(NSUInteger)page
{
    _callback = callback;
    
    NSString *apiUrlString = [self apiEndpoint:@"getevents" page:page];
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //        NSInteger totalPages  = [[[JSON objectForKey:@"attributes"] objectForKey:@"totalpages"] intValue] || 1;
        NSMutableArray *eventsToReturn = [NSMutableArray array];
        NSArray *eventList = [JSON objectForKey:@"events"];
        
        for (NSDictionary *event in eventList) {
            Event *evt = [[Event alloc] initWithJSON:event];
            [eventsToReturn addObject:evt];
        }
        
        _callback(eventsToReturn);
        
    } failure:nil];
    
    [operation start];
}

- (NSString *) apiEndpoint:(NSString *)method page:(NSUInteger)page {
    return [NSString stringWithFormat:@"%@/%@/%@/%@?page=%d",
            self.noiteHojeWSURL,
            self.noiteAPIVersion,
            self.noiteHojeAPIKey,
            method,
            page];
}

@end
