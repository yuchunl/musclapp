//
//  CalendarViewController.m
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//
//Need to continously working on
#import "DSLCalendarView.h"
#import "CalendarViewController.h"
#import "DSLCalendarMonthView.h"
#import "DSLCalendarDayView.h"
#import "WorkoutRecord.h"
#import "UserProfile.h"



@interface CalendarViewController () <DSLCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet DSLCalendarView *calendarView;

@end


@implementation CalendarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the frame size
    CGRect frame = CGRectMake(0, 0, 320, 350);
    self.calendarView = [[DSLCalendarView alloc] initWithFrame:frame];
    [self.calendarViewContainer addSubview:self.calendarView];
    
    //set the table and button
    self.calendarView.delegate = self;
    [self.calendarView didTapMonthBack:nil];
    [self.calendarView didTapMonthForward:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DSLCalendarViewDelegate methods

//select  a day by user
- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    if (range != nil) {
        NSLog( @"Selected %ld/%ld - %ld/%ld", (long)range.startDay.day, (long)range.startDay.month, (long)range.endDay.day, (long)range.endDay.month);
        self.selDateLable.text = [self getWorkoutDetailOnMonth:range.startDay.month andDay:range.startDay.day];
    }
    else {
        NSLog( @"No selection" );
    }
}

//drag a signle day
- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
}

//hightlight the date that has activity
- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
    
    // get the month view
    DSLCalendarMonthView* monthView = [calendarView getVisibleMonthView];
    
//    // reset all dayviews
//    for (DSLCalendarDayView* dv in monthView.dayViews) {
//        dv.hasActivity = NO;
//    }
    
    // set up data with acitveity
    NSArray* days = [WorkoutRecord fetchWorkoutDaysInMonth:month.month];
    for (NSString* dayStr in days) {
        NSDateComponents* date = [month copy];
        [date setDay:dayStr.intValue];
        DSLCalendarDayView* dayView = [monthView dayViewForDay:date];
        dayView.hasActivity = YES;
        
    }
    [monthView setNeedsDisplay];
}

//check if the month change or not
- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
    
}


- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}

//get the workout data from workoutRecord and change with the right format
-(NSString*) getWorkoutDetailOnMonth:(int)month andDay:(int)day{

    NSString* detailStr;
    NSArray *workouts = [WorkoutRecord fetchWorkoutOnMonth:month andDay:day];
    if (workouts.count == 0) {
        detailStr = @"No activity.";
    }
    else{
        detailStr = workouts[0];
        for (int i = 1; i < workouts.count; i++ ) {
            detailStr = [NSString stringWithFormat:@"%@\n%@", detailStr, workouts[i]];
        }
    }
    
    //make a correct format
    UserProfile* userPrfile = [UserProfile sharedUserProfile];
    detailStr = [detailStr stringByReplacingOccurrencesOfString:@"username:" withString:@""];
    detailStr = [detailStr stringByReplacingOccurrencesOfString: userPrfile.username withString:@""];
    detailStr = [detailStr stringByReplacingOccurrencesOfString: @",day:" withString:@"/"];
    detailStr = [detailStr stringByReplacingOccurrencesOfString: @",part:" withString:@"-"];
    detailStr = [detailStr stringByReplacingOccurrencesOfString: @",month:" withString:@"Day:"];
    
    return detailStr;
}



@end