//
//  Event.h
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *dateRelative;
@property (nonatomic, copy) NSString *dateHuman;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *eventID;
@property (nonatomic, copy) NSString *shortURL;

@end
