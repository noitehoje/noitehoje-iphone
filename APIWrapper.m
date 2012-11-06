//
//  APIWrapper.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "APIWrapper.h"
#import "Event.h"

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
    _callback = callback;
    
    NSString *apiUrlString = [self apiEndpoint:@"getevents"];
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        _eventData = [NSMutableData data];
    }
    else {
        _callback(nil);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_eventData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_eventData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _eventData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *myError = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:_eventData options:NSJSONReadingMutableLeaves error:&myError];
    NSInteger totalPages  = [[[results objectForKey:@"attributes"] objectForKey:@"totalpages"] intValue] || 1;
    NSMutableArray *eventsToReturn = [NSMutableArray array];
    NSArray *eventList = [results objectForKey:@"events"];
    
    for (NSDictionary *event in eventList) {
        Event *evt = [[Event alloc] initWithJSON:event];
        [eventsToReturn addObject:evt];
    }
    
    _callback(eventsToReturn);
}

- (NSString *) apiEndpoint:(NSString *)method {
  return [NSString stringWithFormat:@"%@/%@/%@/%@",
    self.noiteHojeWSURL,
    self.noiteAPIVersion,
    self.noiteHojeAPIKey,
    method];
}

@end
