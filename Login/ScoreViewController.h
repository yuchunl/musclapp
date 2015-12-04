//
//  ViewController.h
//  Score
//
//  Created by Hartono Salim on 10/24/14.
//
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController{
    
    NSUInteger reps;
    NSString *gender;
    
    int score;
    double genderModifier;
    int min;
    int hour;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *returnLevel;
@property int selectedLevel;
@property NSString *selectedPart;
@property NSUInteger reps;
@property double distance;
@property int sec;
@property NSString* day;

-(void)score;
-(void)calculateStars;
- (void) updateUserExercise;
-(void) createRecord;

@end
