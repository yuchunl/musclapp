//
//  UserProfile.h
//  Muscalapp
//
//  Created by Yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserProfile : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic) NSString* username;
@property (nonatomic) NSString* password;
@property (nonatomic) NSString* gender;
@property (nonatomic) NSString* age;
@property (nonatomic) NSString* height;
@property (nonatomic) NSString* weight;

@property (nonatomic) BOOL isNewUser;

+ (UserProfile*)sharedUserProfile;

- (void) clear;
- (id) init;

- (BOOL) verifyUsername:(NSString*) name andPassword:(NSString*) pwd;
- (BOOL) hasRegistered:(NSString*) name;

- (void) saveProfile;
- (void) fetchProfile;



@end
