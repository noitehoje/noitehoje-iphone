//
//  APIWrapper.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "APIWrapper.h"
#import <YAJLiOS/YAJL.h>

@implementation APIWrapper

@synthesize noiteHojeWSURL, noiteAPIVersion, noiteHojeAPIKey;

- (id)init {  
  self = [super init];
  if (self) {
    self.noiteHojeWSURL = @"http://noitehoje.com.br/api";
    self.noiteAPIVersion = @"v1";
    self.noiteHojeAPIKey = @"crEjew8r";
  }
  return self;
}

- (NSArray *)events {
  NSString *apiUrlString = [self apiEndpoint:@"getevents"];
  NSURL *url = [NSURL URLWithString:apiUrlString];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  if (connection) {
    _eventData = [NSMutableData data];
  }
  else {
    // Request failed
  }
  
  request = nil;
  
  return [NSArray array];
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
  NSString *jsonString  = [[NSString alloc] initWithData:_eventData encoding:NSUTF8StringEncoding];
  NSArray *jsonArray = [jsonString yajl_JSON];
  NSLog(@"%@", jsonArray);
  //NSInteger totalPages  = [[[results objectForKey:@"attributes"] objectForKey:@"totalpages"] intValue] || 1;
  
}

- (NSString *) apiEndpoint:(NSString *)method {
  return [NSString stringWithFormat:@"%@/%@/%@/%@",
    self.noiteHojeWSURL,
    self.noiteAPIVersion,
    self.noiteHojeAPIKey,
    method];
}

@end
