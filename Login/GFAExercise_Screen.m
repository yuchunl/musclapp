//
//  GFAExercise_Screen.m
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/22/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import "GFAExercise_Screen.h"
#import "ScoreViewController.h"
#import "GFACoreMotion.h"


@interface GFAExercise_Screen ()<motion>
@property (strong, nonatomic) GFACoreMotion * cm;
@end

@implementation GFAExercise_Screen

@synthesize Start, Stop, Distance;

@synthesize selectedLevel, selectedPart;
@synthesize time, Repetitions, countDownLable;

NSThread *accelThread;
NSUInteger reps = 0;
double TotalDistance = 0;
int sec = 0;
int min = 0;
int hour = 0;

//alloc
- (GFACoreMotion*) cm
{
    if(!_cm)
    {
        _cm =[[GFACoreMotion alloc]init];
    }
    return _cm;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self reset];
    [Distance setText: @"0 m"];
    Stop.hidden=TRUE;
    time.hidden=TRUE;
    Repetitions.hidden = TRUE;
    countDownLable.hidden = TRUE;
    
}

//accelerometer connect
-(void) StartExercise
{
    [self.cm setDelegate: self];
    [self.cm startAccelMotionMoniteringWithLevel:selectedLevel andPart:selectedPart/*andThread: accelThread*/];
}

//new instance resetter
- (void) reset
{
    sec = 0;
    min = 0;
    hour = 0;
    reps = 0;
    
}


//timer


- (void) timecount
{
    sec += 1;
    min = sec/60;
    hour = sec/3600;
    [time setText: [NSString stringWithFormat: @"%i : %i : %i", hour, (min%60), (sec%60)]];
    //printf("timer started");//for testing perposes
}



//segue sends information to next slide
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ScoreViewController * scoreScreen =[segue destinationViewController];
    scoreScreen.reps = reps;
    scoreScreen.distance = TotalDistance;
    scoreScreen.sec = sec;
    scoreScreen.selectedLevel = selectedLevel;
    scoreScreen.selectedPart = selectedPart;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//Delegate//recives informaion from core motion
- (void)returnValuesWithReps:(NSUInteger)rep andTotalDistance:(double)distance
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        TotalDistance = distance;
        reps = rep;
        Distance.text = [NSString stringWithFormat:@"%.1f m", TotalDistance];
        Repetitions.text = [NSString stringWithFormat:@"Reps: %lu", (unsigned long)reps];
    }];
}

//save the distance,rep,time
- (void)savedExerciseInfor{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TotalDistance forKey:@"distance"];
    [defaults setInteger:reps forKey:@"reps"];
    [defaults setInteger:sec forKey:@"sec"];
}

// a coutdown that should show after pressing start in the exercise screen
- (void)countdown
{
    __block NSString *count;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        countDownLable.hidden = FALSE;
        for (int i = 3; i >=0; i--)
        {
            count = [NSString stringWithFormat:@"%d",i];
            countDownLable.text = count;
            sleep(1);
        }
        countDownLable.hidden = TRUE;
    }];
    
    
    
}

//buttons
- (IBAction)Start:(id)sender {
    
    [self countdown];
    [self makeSound];
    Start.hidden = TRUE;
       //does do the countdown but it isn't visiable
    Repetitions.hidden = FALSE;
    time.hidden = FALSE;
//    accelThread = [[NSThread alloc] initWithTarget:self selector:@selector(StartExercise) object:self.cm];
//    [accelThread start];
    [NSThread detachNewThreadSelector: @selector(StartExercise) toTarget: self withObject: self.cm];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector:@selector(timecount) userInfo:nil repeats:YES];
    Stop.hidden = FALSE;

}

//the stop button
- (IBAction)Stop:(id)sender {
    [self.cm stopAccelMotionMonitring];
    [self savedExerciseInfor];
    [timer invalidate];
//    [accelThread cancel];
}


//make sound when counting down
- (void) makeSound{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"mp3"];
    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [theAudio play];
}
@end
