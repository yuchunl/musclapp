//
//  GFASelection_Screen.m
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/23/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//


#import "GFASelection_Screen.h"
#import "GFAInstrunctions_Screen.h"
#import "LevelDocument.h"


@interface GFASelection_Screen ()

@end

@implementation GFASelection_Screen
@synthesize StarNum;
@synthesize ArmScore;
@synthesize CoreScore;
@synthesize LegScore;
@synthesize Level;
@synthesize selectedLevel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self setScreen];
}

// function to set up the sceen with the proper information
- (void) setScreen
{
    LevelDocument *levelInfo = [LevelDocument sharedLevelDocument];
    [levelInfo fetchExerciseRocord];
    Level.title = [NSString stringWithFormat:@"Level %d", selectedLevel];
    if (selectedLevel == 1)
    {
        StarNum.text = [NSString stringWithFormat:@"x %@", levelInfo.Stars_1];
        ArmScore.text = [NSString stringWithFormat:@"%@", levelInfo.a_score_1];
        CoreScore.text = [NSString stringWithFormat:@"%@", levelInfo.c_score_1];
        LegScore.text = [NSString stringWithFormat:@"%@", levelInfo.l_score_1];
        
    }
    else if (selectedLevel == 2)
    {
        StarNum.text = [NSString stringWithFormat:@"x %@", levelInfo.Stars_2];
        ArmScore.text = [NSString stringWithFormat:@"%@", levelInfo.a_score_2];
        CoreScore.text = [NSString stringWithFormat:@"%@", levelInfo.c_score_2];
        LegScore.text = [NSString stringWithFormat:@"%@", levelInfo.l_score_2];
    }
    else if (selectedLevel == 3)
    {
        StarNum.text = [NSString stringWithFormat:@"x %@", levelInfo.Stars_3];
        ArmScore.text = [NSString stringWithFormat:@"%@", levelInfo.a_score_3];
        CoreScore.text = [NSString stringWithFormat:@"%@", levelInfo.c_score_3];
        LegScore.text = [NSString stringWithFormat:@"%@", levelInfo.l_score_3];
    }
    [self makeZero];
}

//if string is null due to database informaton replace the (null) with 0
- (void)makeZero{
    StarNum.text = [StarNum.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"0"];
    ArmScore.text = [ArmScore.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"0"];
    CoreScore.text = [CoreScore.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"0"];
    LegScore.text = [LegScore.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"0"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GFAInstrunctions_Screen *IS = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"Arm"])
    {
        IS.selectedLevel = selectedLevel;
        IS.selectedPart = @"Arm";
    }
    else if ([segue.identifier isEqualToString:@"Core"])
    {
        IS.selectedLevel = selectedLevel;
        IS.selectedPart = @"Core";
        
    }
    else if ([segue.identifier isEqualToString:@"Leg"])
    {
        IS.selectedLevel = selectedLevel;
        IS.selectedPart = @"Leg";
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
