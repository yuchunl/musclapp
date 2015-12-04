//
//  GFAExercise_Screen.h
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/22/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>




@interface GFAExercise_Screen : UIViewController<UIAccelerometerDelegate, AVAudioPlayerDelegate>
{
    
    float xValue;
    float yValue;
    float zValue;
    
    NSTimer *timer;
}

- (IBAction)Start:(id)sender;
- (IBAction)Stop:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *countDownLable;
@property (weak, nonatomic) IBOutlet UILabel *Repetitions;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *Start;
@property (weak, nonatomic) IBOutlet UIButton *Stop;

@property (weak, nonatomic) IBOutlet UILabel *Distance;

@property int selectedLevel;
@property NSString * selectedPart;

- (void) savedExerciseInfor;
- (void) makeSound;



@end
