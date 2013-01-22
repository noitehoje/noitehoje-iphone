//
//  NHApplication.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 1/21/13.
//  Copyright (c) 2013 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface NHApplication : NSObject

@property (nonatomic, strong) User *currentUser;

+ (id)instance;

@end
