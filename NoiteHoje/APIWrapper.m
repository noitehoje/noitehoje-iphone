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
#import "NSString+URLEncoding.h"

@implementation APIWrapper

- (id)init {
    self = [super init];
    if (self) {
        self.noiteHojeWSURL = @"http://api.noitehoje.com.br/api";
        self.noiteAPIVersion = @"v1";
        self.noiteHojeAPIKey = @"crEjew8r";
    }
    return self;
}

- (void)citiesWithCallback:(void (^)(NSArray *))callback
{
    NSLog(@"requesting cities");
    NSString *apiUrlString = [self apiEndpoint:@"getcities"];
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [[AFJSONRequestOperation
     JSONRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
         NSArray *cities = (NSArray *)JSON;
         callback(cities);
     } failure:nil] start];
}

- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback
{
    [self eventsWithCallback:callback andPage:1];
}

- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback page:(NSUInteger)page andCity:(NSString *)city
{
    NSLog(@"requesting events at page %d and city %@", page, city);
    NSString *apiUrlString = [self apiEndpoint:@"getevents" page:page andCity:city];
    NSLog(@"url %@", apiUrlString);
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self requestEvents:request callback:callback];
}

- (void)eventsWithCallback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback andPage:(NSUInteger)page
{
    NSLog(@"requesting events at page %d", page);
    NSString *apiUrlString = [self apiEndpoint:@"getevents" page:page];
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self requestEvents:request callback:callback];
}

- (void)requestEvents:(NSURLRequest *)request callback:(void (^)(NSArray *, NSUInteger, NSUInteger))callback
{
    [[AFJSONRequestOperation
     JSONRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
         NSInteger totalPages  = [[[JSON objectForKey:@"attributes"] objectForKey:@"totalpages"] intValue];
         NSInteger currentPage  = [[[JSON objectForKey:@"attributes"] objectForKey:@"page"] intValue];
         NSMutableArray *eventsToReturn = [NSMutableArray array];
         NSArray *eventList = [JSON objectForKey:@"events"];
         
         for (NSDictionary *event in eventList) {
             Event *evt = [[Event alloc] initWithJSON:event];
             [eventsToReturn addObject:evt];
         }
         
         callback(eventsToReturn, currentPage, totalPages);
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
         NSLog(@"request failed");
     }] start];
}

- (NSString *) apiEndpoint:(NSString *)method page:(NSUInteger)page {
    return [NSString stringWithFormat:@"%@/%@/%@/%@?page=%d",
            self.noiteHojeWSURL,
            self.noiteAPIVersion,
            self.noiteHojeAPIKey,
            method,
            page];
}

- (NSString *) apiEndpoint:(NSString *)method page:(NSUInteger)page andCity:(NSString *)city {
    return [NSString stringWithFormat:@"%@/%@/%@/%@?page=%d&location=%@",
            self.noiteHojeWSURL,
            self.noiteAPIVersion,
            self.noiteHojeAPIKey,
            method,
            page,
            [city urlEncode]];
}

- (NSString *) apiEndpoint:(NSString *)method {
    return [NSString stringWithFormat:@"%@/%@/%@/%@",
            self.noiteHojeWSURL,
            self.noiteAPIVersion,
            self.noiteHojeAPIKey,
            method];
}

@end
