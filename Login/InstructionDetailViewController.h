//
//  InstructionDetailViewController.h
//  Login
//
//  Created by Honghua Li on 2014-11-19.
//  Copyright (c) 2014 SFU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *subtitlename;
@property (strong, nonatomic) NSString* titleContents;
@property (strong, nonatomic) NSString* subtitleContents;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;

@property (weak, nonatomic) IBOutlet UIImageView *pos;
@property (weak, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UITextView *detail;



-(void)showImageLabel;

@end
