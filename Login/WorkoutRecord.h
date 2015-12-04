//
//  WorkoutRecord.h
//  Muscalapp
//
//  Created by yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutRecord : NSObject

@property (nonatomic) NSString* month;
@property (nonatomic) NSString* day;
@property (nonatomic) NSString* level;
@property (nonatomic) NSString* score;
@property (nonatomic) NSString* part;

+ (WorkoutRecord*)sharedWorkoutRecord;

- (void) clear;
- (id) init;


+ (NSArray*) fetchWorkoutDaysInMonth:(int)month;
+ (NSArray*) fetchWorkoutOnMonth:(int)month andDay: (int)day;
- (void) saveWorkoutRecord;


@end
