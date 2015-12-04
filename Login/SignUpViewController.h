//
//  SignUpViewController.h
//
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface SignUpViewController : UIViewController
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *verify;
        
    IBOutlet UIImageView *checkMarkUser;
    IBOutlet UIImageView *checkMarkPwd;
    IBOutlet UIImageView *checkMarkVer;
    
    IBOutlet UIButton *signUp;
}

- (IBAction)validateUsername:(id)sender;
- (IBAction)validatePwd:(id)sender;
- (IBAction)validateVer:(id)sender;

- (IBAction)onSignUp:(id)sender;


@end
