//
//  UserProfile.m
//  Muscalapp
//
//  Created by Yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "UserProfile.h"

#define profileFetcher @"http://104.236.21.79/workspace/TestProject/profile.php"
#define profileCreator @"http://104.236.21.79/workspace/TestProject/createProfile.php"
#define profileUpdater @"http://104.236.21.79/workspace/TestProject/updateProfile.php"


@interface UserProfile()
{
    NSMutableData *_downloadedData;
}
@end


@implementation UserProfile

// singleton design pattern
+ (UserProfile*)sharedUserProfile{
    
    static UserProfile *_sharedInstance = nil;
    
    if (_sharedInstance == nil) {
        _sharedInstance = [[UserProfile alloc] init];
    };
    return _sharedInstance;
}

//initial all the variable
- (id) init{
    if ( self = [super init] ) {
        [self clear];
        return self;
    } else
        return nil;
}

//clear the profile
- (void) clear
{
    self.username = nil;
    self.password = nil;
    self.gender = nil;
    self.age = nil;
    self.weight = nil;
    self.height = nil;
    
    self.isNewUser = YES;
}

//vaild username with vaild password
-(BOOL) verifyUsername:(NSString*) name andPassword:(NSString*) pwd
{
    // append the username to the url
    NSString *url_name = [NSString stringWithFormat:@"%@?username=%@", profileFetcher, name];
    NSURL *url = [NSURL URLWithString:url_name];
    NSData *data = [NSData dataWithContentsOfURL:url];
        
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
    NSString* storedPwd = [results valueForKey:@"password"];
    self.username = name;
    return  [storedPwd isEqual:pwd];

}

//check the user has been registered or not
- (BOOL) hasRegistered:(NSString*) name{
    // append the username to the url
    NSString *url_name = [NSString stringWithFormat:@"%@?username=%@", profileFetcher, name];
    NSURL *url = [NSURL URLWithString:url_name];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    return [results count] > 0;
}

//save new user account from app to MySQL
- (void) saveProfile{
    
    // the url
    NSString* target;
    if (self.isNewUser) {
        target = profileCreator;
        self.isNewUser = NO;
    }else{
        target = profileUpdater;
    }
    
    NSString* url = [NSString stringWithFormat:@"%@?username=%@&password=%@&gender=%@&age=%@&weight=%@&height=%@",
                 target, self.username, self.password, self.gender, self.age, self.weight, self.height];;
    
    // create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy   timeoutInterval:60.0];
    
    // create the connection and send the request
    [NSURLConnection sendSynchronousRequest:theRequest returningResponse:NULL error:nil];
}


//load user profile data form URL to app
- (void) fetchProfile
{
    // append the username to the url
    NSString *profile_url = [NSString stringWithFormat:@"%@?username=%@", profileFetcher, _username];
    NSURL *url = [NSURL URLWithString:profile_url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSString* genderData = [results valueForKey:@"gender"];
    NSString* ageData = [results valueForKey:@"age"];
    NSString* heightData = [results valueForKey:@"height"];
    NSString* weightData = [results valueForKey:@"weight"];
    
    self.gender = genderData;
    self.age = ageData;
    self.weight = weightData;
    self.height = heightData;
}


@end
