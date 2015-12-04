//
//  WorkoutRecord.m
//  Login
//
//  Created by Yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "WorkoutRecord.h"
#import "UserProfile.h"

#define workoutFetcher @"http://104.236.21.79/workspace/TestProject/workout.php"
#define workoutDayFetcher @"http://104.236.21.79/workspace/TestProject/workoutDays.php"
#define workoutCreator @"http://104.236.21.79/workspace/TestProject/createWorkout.php"

@interface WorkoutRecord()
{
    NSMutableData *_downloadedData;
}
@end

@implementation WorkoutRecord

// singleton design pattern
+ (WorkoutRecord*)sharedWorkoutRecord{
    
    static WorkoutRecord *_sharedInstance = nil;
    
    if (_sharedInstance == nil) {
        _sharedInstance = [[WorkoutRecord alloc] init];
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
    self.month = nil;
    self.day = nil;
    self.level = nil;
    self.score = nil;
}

//fetch the date
+ (NSArray*) fetchWorkoutDaysInMonth:(int)month{
    
    // append the username to the url
    NSString* monthStr = [NSString stringWithFormat:@"%d", month];
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    NSString *workoutDay_url = [NSString stringWithFormat:@"%@?username=%@&month=%@", workoutDayFetcher, userProfile.username, monthStr];
    NSURL *url = [NSURL URLWithString:workoutDay_url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //delete the brackets
    NSString *noRightBrackets = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *noBrackets = [noRightBrackets stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString* noQuotation = [noBrackets stringByReplacingOccurrencesOfString:@"\"" withString:@""];

    NSLog(@"%@", noQuotation);
    
    //Separate the string into array
    NSMutableArray* days = [[NSMutableArray alloc] init];
    NSArray* components = [noQuotation componentsSeparatedByString: @"day:"];
    days = [NSMutableArray arrayWithArray:components];
    if (days != nil && days.count > 0)
        [days removeObjectAtIndex: 0];

    return days;
}

//fetch the user infro of that date
+ (NSArray*) fetchWorkoutOnMonth:(int)month andDay:(int)day{
    
    // append the username to the url
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    NSString* m = [NSString stringWithFormat:@"%d", month];
    NSString* d = [NSString stringWithFormat:@"%d", day];
    NSString *workout_url = [NSString stringWithFormat:@"%@?username=%@&month=%@&day=%@", workoutFetcher, userProfile.username, m, d];
    NSURL *url = [NSURL URLWithString:workout_url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString: @"\"" withString:@""];
    
    NSMutableArray* separateString = nil;
    NSUInteger count = 0;
    
    if ([string isEqualToString:@""]) {
        separateString = nil;
    }
    else{
        //count number of "}{"
        NSUInteger length = [string length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound)
        {
            range = [string rangeOfString: @"}{" options:0 range:range];
            if(range.location != NSNotFound)
            {
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                count++; 
            }
        }
    
        //separate string into array
        separateString = [string componentsSeparatedByString:@"}{"];
    
        //delete brackets
        for (int i=0; i< count+1; i++) {
            separateString[i] = [separateString[i] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            separateString[i] = [separateString[i] stringByReplacingOccurrencesOfString:@"{" withString:@""];
        }
    
    }
    return separateString;
}

//save the workout record into URL
- (void) saveWorkoutRecord{
    
    // append the username to the url
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    
    // the url
    NSString* target;
    target = workoutCreator;

    NSString* url = [NSString stringWithFormat:@"%@?username=%@&month=%@&day=%@&level=%@&part=%@&score=%@",
                     target, userProfile.username, self.month, self.day, self.level, self.part, self.score];
    
    // create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy   timeoutInterval:60.0];
    
    // create the connection and send the request
    [NSURLConnection sendSynchronousRequest:theRequest returningResponse:NULL error:nil];
}




@end
