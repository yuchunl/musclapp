//
//  MainViewController.m
//  Login
//
//  Created by Honghua Li on 2014-10-31.
//  Copyright (c) 2014 SFU. All rights reserved.
//

#import "MainViewController.h"
#import "UserProfile.h"

@implementation MainViewController

//save all the data if log off
- (IBAction)onLogoff:(id)sender {
    
    UserProfile* userProfile = [UserProfile sharedUserProfile];
    [userProfile saveProfile];
    
}

@end
