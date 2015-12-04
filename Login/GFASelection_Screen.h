//
//  GFASelection_Screen.h
//  Musclapp v0.01
//
//  Created by Davidson Kao on 10/23/14.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GFASelection_Screen : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *Level;
@property (weak, nonatomic) IBOutlet UILabel *StarNum;
@property (weak, nonatomic) IBOutlet UILabel *ArmScore;
@property (weak, nonatomic) IBOutlet UILabel *CoreScore;
@property (weak, nonatomic) IBOutlet UILabel *LegScore;

//information from previous screen
@property int selectedLevel;

@end
