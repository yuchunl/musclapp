//
//  LevelDocument.m
//  Login
//
//  Created by yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "LevelDocument.h"
#import "UserProfile.h"
#define exerciseFetcher @"http://104.236.21.79/workspace/TestProject/exercise.php"
#define exerciseCreator @"http://104.236.21.79/workspace/TestProject/createExercise.php"
#define exerciseUpdater @"http://104.236.21.79/workspace/TestProject/updateExercise.php"

@implementation LevelDocument

// singleton design pattern
+ (LevelDocument *)sharedLevelDocument
{
    static LevelDocument *_sharedInstance = nil;
    
    if (_sharedInstance == nil) {
        _sharedInstance = [[LevelDocument alloc] init];
    };
    return _sharedInstance;
}

//initial all variables
- (id) init{
    if ( self = [super init] ) {
        [self clear];
        return self;
    } else
        return nil;
}

//clear all variables
- (void) clear
{
    self.a_score_1 = nil;
    self.a_score_2 = nil;
    self.a_score_3 = nil;
    self.c_score_1 = nil;
    self.c_score_2 = nil;
    self.c_score_3 = nil;
    self.l_score_1 = nil;
    self.l_score_2 = nil;
    self.l_score_3 = nil;
    self.Stars_1 = nil;
    self.Stars_2 = nil;
    self.Stars_3 = nil;
}


//fetch exercise record
-(void)fetchExerciseRocord{

    // append the username to the url
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    NSString *exercise_url = [NSString stringWithFormat:@"%@?username=%@", exerciseFetcher, userProfile.username];
    NSURL *url = [NSURL URLWithString:exercise_url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //get each level's star
    self.Stars_1= [results valueForKey:@"Stars_1"];
    self.Stars_2= [results valueForKey:@"Stars_2"];
    self.Stars_3= [results valueForKey:@"Stars_3"];
    
    //get level 1 (arm, core, legs)'s score from database
    self.a_score_1= [results valueForKey:@"a_score_1"];
    self.c_score_1= [results valueForKey:@"c_score_1"];
    self.l_score_1= [results valueForKey:@"l_score_1"];
    
    //get level 2 (arm, core, legs)'s score from database
    self.a_score_2= [results valueForKey:@"a_score_2"];
    self.c_score_2= [results valueForKey:@"c_score_2"];
    self.l_score_2= [results valueForKey:@"l_score_2"];
    
    //get level 3 (arm, core, legs)'s score from database
    self.a_score_3= [results valueForKey:@"a_score_1"];
    self.c_score_3= [results valueForKey:@"c_score_3"];
    self.l_score_3= [results valueForKey:@"l_score_3"];

}


//save user exercise infro in URL
-(void)saveExerciseRecord{
    
    //append username
    UserProfile *userProfile = [UserProfile sharedUserProfile];

    // the url
    NSString* target;
    if (self.isNewExerciseUser) {
        target = exerciseCreator;
        self.isNewExerciseUser = NO;
    }else{
        target = exerciseUpdater;
    }
    
    //put user infro in URL
    NSString* url = [NSString stringWithFormat:@"%@?username=%@&Stars_1=%@&Stars_2=%@&Stars_3=%@&a_score_1=%@&c_score_1=%@&l_score_1=%@&a_score_2=%@&c_score_2=%@&l_score_2=%@&a_score_3=%@&c_score_3=%@&l_score_3=%@",
                     target, userProfile.username, self.Stars_1, self.Stars_2, self.Stars_3, self.a_score_1, self.c_score_1, self.l_score_1, self.a_score_2, self.c_score_2, self.l_score_2, self.a_score_3, self.c_score_3, self.l_score_3];;
    
    // create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy   timeoutInterval:60.0];
    
    // create the connection and send the request
    [NSURLConnection sendSynchronousRequest:theRequest returningResponse:NULL error:nil];

}



//Compare current score and previous score in a specific level
-(void) compareTwoScore: (int)level andBodyPart:(NSString*)part andCurrentScore: (int)currentScore{
    
    //get the previous score
    [self fetchExerciseRocord];
    
    
    //replace to current score if no data or bigger than previous score
    if (level==1 && [part isEqualToString:@"Arm"]) {
        
        if ( [self.a_score_1 isEqualToString:@""] ||  currentScore > self.a_score_1.intValue ) {
            self.a_score_1 = [NSString stringWithFormat: @"%d", currentScore];
        }
    }else if (level ==1 && [part isEqualToString:@"Core"]){
        
        if ([self.c_score_1 isEqualToString:@""] || currentScore > self.c_score_1.intValue) {
            self.c_score_1 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==1 && [part isEqualToString:@"Leg"]){
        
        if ([self.l_score_1 isEqualToString:@""] || currentScore > self.l_score_1.intValue) {
            self.l_score_1 = [NSString stringWithFormat: @"%d", currentScore];
            
        }
    }else if(level ==2 && [part isEqualToString:@"Arm"]){
        
        if ([self.a_score_2 isEqualToString:@""] || currentScore > self.a_score_2.intValue) {
            self.a_score_2 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==2 && [part isEqualToString:@"Core"]){
        
        if ([self.c_score_2 isEqualToString:@""] || currentScore > self.c_score_2.intValue) {
            self.c_score_2 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==2 && [part isEqualToString:@"Leg"]){
        
        if ([self.l_score_2 isEqualToString:@""] || currentScore > self.l_score_2.intValue) {
            self.l_score_2 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==3 && [part isEqualToString:@"Arm"]){
        
        if ([self.a_score_3 isEqualToString:@""] || currentScore > self.a_score_3.intValue) {
            self.a_score_3 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==3 && [part isEqualToString:@"Core"]){
        
        if ([self.c_score_3 isEqualToString:@""] || currentScore > self.c_score_3.intValue) {
            self.c_score_3 = [NSString stringWithFormat: @"%d", currentScore];
        }
        
    }else if(level ==3 && [part isEqualToString:@"Leg"]){
        
        if ([self.l_score_3 isEqualToString:@""] ||currentScore > self.l_score_3.intValue) {
            self.l_score_3 = [NSString stringWithFormat: @"%d", currentScore];
        }
    }
    
    //save it
    [self saveExerciseRecord];
}


@end
