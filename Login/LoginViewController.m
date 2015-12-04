//
//  ViewController.m
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//
#import "LoginViewController.h"
#import "UserProfile.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //reminder to connect wifi
    UIAlertView *strechAlert = [[UIAlertView alloc]initWithTitle:@"Reminder"
                                                         message:@"Please connect with wifi"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [strechAlert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//text field animation to avoid keyboard covering
- (IBAction)EditingDidBegin:(id)sender {
    [self textFieldDidBeginEditing:password];
}
- (IBAction)EditingDidEnd:(id)sender {
    [self textFieldDidEndEditing:password];
}
- (IBAction)DidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

//text field animation to avoid keyboard covering
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

//move the textField up
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//login to the main screen
-(IBAction)login:(id)sender{
    
    UserProfile* userProfile = [UserProfile sharedUserProfile];
    BOOL valid = [userProfile verifyUsername:username.text andPassword:password.text];
    
    if (valid) {
        //[userProfile load:username.text];
        userProfile.isNewUser = NO;
    }
    else{
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:@"Either the username or the password is incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }
}


@end
