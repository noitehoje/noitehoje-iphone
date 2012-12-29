//
//  NSString+URLEncoding.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 12/28/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

// Based on http://madebymany.com/blog/url-encoding-an-nsstring-on-ios

-(NSString *)urlEncode {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

@end
