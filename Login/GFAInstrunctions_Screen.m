//
//  GFAInstrunctions.m
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/22/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import "GFAInstrunctions_Screen.h"
#import "GFASelection_Screen.h"
#import "GFAExercise_Screen.h"

@interface GFAInstrunctions_Screen ()

@end

@implementation GFAInstrunctions_Screen
@synthesize ExerciseName;
@synthesize ExercisePicture;
@synthesize instructionsText;

@synthesize selectedLevel;
@synthesize selectedPart;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self screenSet];
}

//sets the screen up correctly with the input from the last screen (level and part)
- (void) screenSet
{
    if (selectedLevel == 1 && [selectedPart isEqualToString:@"Arm"])
    {
        ExerciseName.text = @"Wall Push Up";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"WallPushUp1.png"],
                                           [UIImage imageNamed:@"WallPushUp2.png"], nil];
        instructionsText.text = @"Face a wall with both hands outstretched to it. Lean the body forward towards the wall, and push back to initial position. Use an arm strap to keep the iPhone in place.";
    }
    else if (selectedLevel == 1 && [selectedPart isEqualToString:@"Core"])
    {
        ExerciseName.text = @"Sit Up";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"SitUp1.png"],
                                           [UIImage imageNamed:@"SitUp2.png"], nil];
        instructionsText.text = @"Lie down on the ground facing upwards with both feet on the ground and keep both arms straight in the direction you're looking at. Raise your body until your arms hit your knee, and repeat. Hold the iPhone in hand";
    }
    else if (selectedLevel == 1 && [selectedPart isEqualToString:@"Leg"])
    {
        ExerciseName.text = @"Quadruped Leg Lift";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"QuadrupedLegLift1.png"],
                                           [UIImage imageNamed:@"QuadrupedLegLift2.png"],
                                           [UIImage imageNamed:@"QuadrupedLegLift3.png"], nil];
        instructionsText.text = @"Face downwards with arms and knee as a support. Use a leg strap to keep the iPhone steady on one leg. Raise the leg as far as you can, and repeat.";
    }
    else if (selectedLevel == 2 && [selectedPart isEqualToString:@"Arm"])
    {
        ExerciseName.text = @"Push Up";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"PushUp1.png"],
                                           [UIImage imageNamed:@"PushUp2.png"], nil];
        instructionsText.text = @"Lie facing downwards on the floor supported by the arms and feet only. Raise the body by extending arms and keeping the body straight. Use an iPhone arm strap to keep the steady during exercise.";
    }
    else if (selectedLevel == 2 && [selectedPart isEqualToString:@"Core"])
    {
        ExerciseName.text = @"Shoulder Bridge";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"ShoulderBridge1.png"],
                                           [UIImage imageNamed:@"ShoulderBridge2.png"],
                                           [UIImage imageNamed:@"ShoulderBridge3.png"], nil];
        instructionsText.text = @"Lie down facing upwards with arms straight and legs perpendicular so that the feet is touching the ground. Raise your back so it no longer touches the ground and alternate raising legs. Use a leg strap for your iPhone.";
    }
    else if (selectedLevel == 2 && [selectedPart isEqualToString:@"Leg"])
    {
        ExerciseName.text = @"Squat";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"Squat1.png"],
                                           [UIImage imageNamed:@"Squat2.png"], nil];
        instructionsText.text = @"Stand on the ground with arms extended outwards. Lower your body down by flexing both knees and legs. Hold the iPhone in hand.";
    }
    else if (selectedLevel == 3 && [selectedPart isEqualToString:@"Arm"])
    {
        ExerciseName.text = @"T Push Up";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"TPushup1.png"],
                                           [UIImage imageNamed:@"TPushUp2.png"], nil];
        instructionsText.text = @"Lie facing downwards on the floor supported by the arms and feet only. Alternate lifting one arm as far as possible. Use a arm strap to keep the iPhone in place.";
    }
    else if (selectedLevel == 3 && [selectedPart isEqualToString:@"Core"])
    {
        ExerciseName.text = @"Single Leg Deadlift";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"SingleLegLift1.png"],
                                           [UIImage imageNamed:@"SingleLegLift2.png"],
                                           [UIImage imageNamed:@"SingleLegLift3.png"], nil];
        instructionsText.text = @"Lie facing downwards on the floor supported by the arms and feet only. Alternate lifting legs upwards as far as possible. Use a leg strap to hold your iPhone.";// might be wrong
    }
    else if (selectedLevel == 3 && [selectedPart isEqualToString:@"Leg"])
    {
        ExerciseName.text = @"Lunge";
        ExercisePicture.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"Lunge1.png"],
                                           [UIImage imageNamed:@"Lunge2.png"], nil];
        instructionsText.text = @"Hold your iPhone in either of your hands and stretch out both arms outwards of your body while standing. Move one foot forward and your body until the knee is perpendicular with the legs. Return to standing position and repeat by alternating legs.";
    }
    [ExercisePicture setAnimationRepeatCount:0];
    ExercisePicture.animationDuration = 0.8;
    [ExercisePicture startAnimating];
    [instructionsText setFont:[UIFont boldSystemFontOfSize:15]];
}

// didn't get used due to version transfer didn't happen
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"back"])
    {
        GFASelection_Screen *lastScreen = [segue destinationViewController];
        lastScreen.selectedLevel = selectedLevel;
        
    }
    else
    {
        GFAExercise_Screen *ES = [segue destinationViewController];
        ES.selectedLevel = selectedLevel;
        ES.selectedPart = selectedPart;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)ReadyButton:(id)sender {
}
@end
