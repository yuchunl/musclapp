//
//  SignUpViewController.m
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "SignUpViewController.h"
#import "UserProfile.h"
#import "LevelDocument.h"


@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Hide the check mark
    self->checkMarkUser.hidden = YES;
    self->checkMarkPwd.hidden = YES;
    self->checkMarkVer.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//text field animation to avoid keyboard covering
- (IBAction)EditingDidBegin:(id)sender {
    [self textFieldDidBeginEditing:verify];
}
- (IBAction)EditingDidEnd:(id)sender {
    [self textFieldDidEndEditing:verify];
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

//move text field up
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//if all check the check images show, execute the sign up button
- (IBAction)onSignUp:(id)sender {
    
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    LevelDocument*  levelInfor= [LevelDocument sharedLevelDocument];

    // check format
    if (checkMarkUser.hidden || checkMarkPwd.hidden || checkMarkVer.hidden) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:@"Your input was incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }
    // existed user
    else if ([userProfile hasRegistered:username.text]){
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:@"The username has been registered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }
    // sucess
    else
    {
        NSLog(@"Sign up was sucessful.");
        //save current username and password to the UserProfile
        UserProfile *userProfile = [UserProfile sharedUserProfile];
        userProfile.username = self->username.text;
        userProfile.password = self->password.text;
        userProfile.isNewUser = YES;
        levelInfor.isNewExerciseUser = YES;
        [levelInfor saveExerciseRecord];
    }
}

// show the image if username is email format
- (IBAction)validateUsername:(id)sender{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL valid = [emailTest evaluateWithObject:username.text];
    self->checkMarkUser.hidden = !valid;
}

// show the image if password is right format
- (IBAction)validatePwd:(id)sender {
    BOOL valid = [password.text length] > 5 && [password.text length] < 21;
    self->checkMarkPwd.hidden = !valid;
}

// show the image if verify is right format
- (IBAction)validateVer:(id)sender {
    
    BOOL valid = !checkMarkPwd.hidden && [password.text isEqualToString:verify.text];
    self->checkMarkVer.hidden = !valid;
}

@end

