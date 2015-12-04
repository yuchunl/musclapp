//
//  CalendarViewController.h
//  
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//
//Need to continously working on
#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"

@interface CalendarViewController : UIViewController<DSLCalendarViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *calendarViewContainer;
@property (weak, nonatomic) IBOutlet UITextView *selDateLable;


-(void) selectRecordDay;
-(void) highlightActivity;


@end
