//
//  ProfileViewController.m
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import "ProfileViewController.h"
#import "UserProfile.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    // load defaults
    [self loadDefaults];
}

- (void) loadDefaults{
    
    // welcome message
    UserProfile* userProfile = [UserProfile sharedUserProfile];
    self->welcome.text = [NSString stringWithFormat:@"Welcome %@", userProfile.username];
    [userProfile fetchProfile ];

    // gender
    if ([userProfile.gender isEqualToString:@"female"]) {
        [gender setSelectedSegmentIndex:1];
    }
    
    // age, height and weight
    if (userProfile.age != nil && ![userProfile.age isEqualToString:@"null"] ) {
        age.text = [NSString stringWithFormat:@"%@", userProfile.age];
        checkMarkAge.hidden = NO;
    }else{
        checkMarkAge.hidden = YES;
    }
    if (userProfile.height != nil && ![userProfile.height isEqualToString:@"null"] ) {
        height.text = [NSString stringWithFormat:@"%@", userProfile.height];
        checkMarkHeight.hidden = NO;
    }else{
        checkMarkHeight.hidden = YES;
    }
    if (userProfile.weight != nil && ![userProfile.weight isEqualToString:@"null"] ) {
        weight.text = [NSString stringWithFormat:@"%@", userProfile.weight];
        checkMarkWeight.hidden = NO;
    }else{
        checkMarkWeight.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//text field animation to avoid keyboard covering
- (IBAction)EditingDidBegin:(id)sender {
    [self textFieldDidBeginEditing:weight];
}
- (IBAction)EditingDidEnd:(id)sender {
    [self textFieldDidEndEditing:weight];
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

//move the text field up
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//check if the string is number or not
- (BOOL) isNumber:(NSString*)str
{
    return [str rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

// process the bottom if the threee check image is showen
- (IBAction)onSave:(id)sender {

    if (checkMarkAge.hidden || checkMarkHeight.hidden || checkMarkWeight.hidden) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:@"Your input are incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }
    else
        [self updateUserProfile];
}

//save profile into UserProfile
- (void) updateUserProfile{
    
    UserProfile *userProfile = [UserProfile sharedUserProfile];
    userProfile.age = self->age.text;
    userProfile.height = self->height.text;
    userProfile.weight = self->weight.text;
 
    if ([gender selectedSegmentIndex] == 0)
        userProfile.gender = @"male";
    else
        userProfile.gender = @"female";
    
    [userProfile saveProfile];
}

// valid age if it is right format
- (IBAction)validateAge:(id)sender {
    BOOL valid = [self isNumber:age.text] && [age.text intValue] > 0 && [age.text intValue] < 100;
    self->checkMarkAge.hidden = !valid;
}

// valid height if it is right format
- (IBAction)validateHeight:(id)sender {
    BOOL valid = [self isNumber:height.text] && [height.text intValue] > 50 && [height.text intValue] < 300;
    self->checkMarkHeight.hidden = !valid;
}

// valid weight if it is right format
- (IBAction)validateWeight:(id)sender {
    BOOL valid = [self isNumber:weight.text] && [weight.text intValue] > 20 && [weight.text intValue] < 200;
    self->checkMarkWeight.hidden = !valid;
}


@end
