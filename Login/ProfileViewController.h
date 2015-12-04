//
//  ProfileViewController.h
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface ProfileViewController : UIViewController
{
    IBOutlet UILabel *welcome;
    IBOutlet UISegmentedControl *gender;
    IBOutlet UITextField *age;
    IBOutlet UITextField *height;
    IBOutlet UITextField *weight;
        

    IBOutlet UIImageView *checkMarkAge;
    IBOutlet UIImageView *checkMarkHeight;
    IBOutlet UIImageView *checkMarkWeight;

    IBOutlet UIButton *save;
}

-(void) loadDefaults;

- (IBAction)onSave:(id)sender;
- (BOOL) isNumber:(NSString*)str;
- (void) updateUserProfile;

- (IBAction)validateAge:(id)sender;
- (IBAction)validateHeight:(id)sender;
- (IBAction)validateWeight:(id)sender;


@end
