//
//  ScoreViewController.m
//  Login
//
//  Created by Hartono Salim on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "ScoreViewController.h"
#import "LevelDocument.h"
#import "WorkoutRecord.h"

@interface ScoreViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *filledStar1;
@property (weak, nonatomic) IBOutlet UIImageView *filledStar2;
@property (weak, nonatomic) IBOutlet UIImageView *filledStar3;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
@property (weak, nonatomic) IBOutlet UILabel *repLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end

@implementation ScoreViewController
@synthesize returnLevel, selectedLevel, selectedPart;
@synthesize reps, distance, sec;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // hide all filled star
    _filledStar1.hidden = TRUE;
    _filledStar2.hidden = TRUE;
    _filledStar3.hidden = TRUE;
    [self screensetup];
}

- (void) screensetup
{
    [self score];
    //display the number of exercise data
    self.scoreLable.text = [NSString stringWithFormat: @"%d", score];
    self.distanceLable.text = [NSString stringWithFormat: @"%.1f m", distance];
    self.repLable.text = [NSString stringWithFormat: @"%d", reps];
    [self timerDisplay];
    [self calculateStars];
    
    //update score infor
    [self createRecord];
    [self updateUserExercise];
    
}

//timer display setup
- (void)timerDisplay
{
    self.timeLable.text = [NSString stringWithFormat:@"%d:%d:%d", sec/3600, ((sec/60)%60), (sec%60)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//calculate the star in a level
-(void)calculateStars{
    
    //Give 1 star if score is 100-500.
    if (score > 100 && score < 500)
        self.filledStar1.hidden = FALSE;
    
    //Give 2 star if score is 500-3000
    else if (score >= 500 && score < 3000){
        self.filledStar1.hidden = FALSE;
        sleep(.3);
        self.filledStar2.hidden = FALSE;
    }
    
    //Give 3 starts if score is >= 300.
    else if (score >= 3000){
        self.filledStar1.hidden = FALSE;
        sleep(.3);
        self.filledStar2.hidden = FALSE;
        sleep(.3);
        self.filledStar3.hidden = FALSE;
    }
}



//calculate the score
-(void)score{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedGender = [defaults stringForKey:@"gender"];
    
    //Obtain gender from profile.
    //If male, genderModifier = 1, else 1.2.
    if ([savedGender isEqualToString:@"male"])
    {genderModifier = 1;}
    else
    {genderModifier = 1.2;}
    
    score = (int)(genderModifier * (reps * distance));
    
    if (score > 999999)
    {
        //Setting max score to 999,999.
        //The score screen should never output anything larger than 999,999.
        score = 999999;
    }
    printf("%d",score);
}

//update score in levelDocument
- (void) updateUserExercise{
    
    LevelDocument *levelInfor = [LevelDocument sharedLevelDocument];
    
    [levelInfor compareTwoScore: self.selectedLevel andBodyPart:self.selectedPart andCurrentScore: score];
}

//save score into workRecord
-(void) createRecord{
    
    WorkoutRecord* workout = [WorkoutRecord sharedWorkoutRecord];
    
    
    //current day
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.dd"];
    self.day = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", self.day);
    
    //Separate the string into array
    NSMutableArray* singleDay = [self.day componentsSeparatedByString: @"."];
    
    //get month and day
    workout.month = singleDay[0];
    workout.day = singleDay[1];
    
    workout.level = [NSString stringWithFormat:@"%d", self.selectedLevel];
    workout.part  = self.selectedPart;
    workout.score = [NSString stringWithFormat: @"%d", score];
    
    //save it
    [workout saveWorkoutRecord];
    
}






@end