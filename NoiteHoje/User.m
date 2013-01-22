//
//  User.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 1/21/13.
//  Copyright (c) 2013 Noite Hoje. All rights reserved.
//

#import "User.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation User

- (NSString *)displayName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.firstName = [[json objectForKey:@"first_name"] capitalizedString];
        self.lastName = [[json objectForKey:@"last_name"] capitalizedString];
        self.userId = [[json objectForKey:@"last_name"] integerValue];
        self.facebookUid = [json objectForKey:@"uid"];
        self.facebookToken = [json objectForKey:@"token"];
    }
    return self;
}

- (id)initWithFbGraphUser:(NSDictionary<FBGraphUser> *)fbUser
{
    self = [super init];
    if (self) {
        self.firstName = fbUser.first_name;
        self.lastName = fbUser.last_name;
        self.facebookUid = fbUser.id;
    }
    return self;
    
}

- (UIView *)avatarImageWithRect:(CGRect)rect
{
    FBProfilePictureView *avatar = [[FBProfilePictureView alloc] initWithFrame:rect];
    avatar.profileID = self.facebookUid;
    return avatar;
}

@end
