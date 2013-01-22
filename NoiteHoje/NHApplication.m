//
//  NHApplication.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 1/21/13.
//  Copyright (c) 2013 Noite Hoje. All rights reserved.
//

#import "NHApplication.h"

@implementation NHApplication

+ (id)instance
{
    static dispatch_once_t onceToken;
	static NHApplication * instance = nil;
	
	dispatch_once(&onceToken, ^{ instance = [[NHApplication alloc] init]; });
	
	return instance;
}


- (id)init
{
    if (self = [super init]) {
				
	}
    return self;
}

@end
