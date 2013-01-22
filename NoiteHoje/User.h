//
//  User.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 1/21/13.
//  Copyright (c) 2013 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface User : NSObject

@property (nonatomic) NSUInteger userId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *facebookUid;
@property (nonatomic, copy) NSString *facebookToken;
@property (nonatomic, copy) NSString *avatar;

- (NSString *)displayName;

- (id)initWithJSON:(NSDictionary *)json;
- (id)initWithFbGraphUser:(NSDictionary<FBGraphUser> *)fbUser;

- (UIView *)avatarImageWithRect:(CGRect)rect;

@end
