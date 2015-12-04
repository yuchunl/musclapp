//
//  GFALevel_Screen.m
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/23/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import "GFALevel_Screen.h"
#import "GFASelection_Screen.h"


@interface GFALevel_Screen ()

@end

@implementation GFALevel_Screen



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
}

//used to tell the next slide what the level and score is
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Level1"])
    {
        GFASelection_Screen *ss =[segue destinationViewController];
        ss.selectedLevel = 1;
    }
    else if ([segue.identifier isEqualToString:@"Level2"])
    {
        GFASelection_Screen *ss =[segue destinationViewController];
        ss.selectedLevel = 2;
    }
    else if ([segue.identifier isEqualToString:@"Level3"])
    {
        GFASelection_Screen *ss =[segue destinationViewController];
        ss.selectedLevel = 3;
    }
    
}

//after pressing each button there will be a reminder to strech first and will then send you to the next screen
- (IBAction)level1:(id)sender
{
    UIAlertView *strechAlert = [[UIAlertView alloc]initWithTitle:@"Reminder"
                                                         message:@"Remember to strech before preforming any exercise"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ready"
                                               otherButtonTitles:nil];
    [strechAlert show];
}
- (IBAction)level2:(id)sender
{
    UIAlertView *strechAlert = [[UIAlertView alloc]initWithTitle:@"Reminder"
                                                         message:@"Remember to strech before preforming any exercise"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ready"
                                               otherButtonTitles:nil];
    [strechAlert show];
}
- (IBAction)level3:(id)sender
{
    UIAlertView *strechAlert = [[UIAlertView alloc]initWithTitle:@"Reminder"
                                                         message:@"Remember to strech before preforming any exercise"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ready"
                                               otherButtonTitles:nil];
    [strechAlert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
