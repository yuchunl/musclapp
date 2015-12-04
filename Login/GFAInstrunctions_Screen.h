//
//  GFAInstrunctions.h
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/22/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GFAInstrunctions_Screen : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *ExerciseName;
@property (weak, nonatomic) IBOutlet UITextView *instructionsText;
@property (weak, nonatomic) IBOutlet UIImageView *ExercisePicture;

//information from last part
@property  int selectedLevel;
@property  NSString *selectedPart;


- (IBAction)ReadyButton:(id)sender;


@end
