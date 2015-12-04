//
//  ViewController.h
//  
//
//  Created by Yu-Chun Lin on 2014-10-26.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface LoginViewController : UIViewController 
{

    IBOutlet UITextField *username;
    IBOutlet UITextField *password;

    IBOutlet UIButton *login;
    IBOutlet UIButton *Signup;
        
}

-(IBAction)login:(id)sender;

//keyborad
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;


@end

