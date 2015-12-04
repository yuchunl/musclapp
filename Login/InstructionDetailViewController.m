//
//  InstructionDetailViewController.m
//  Login
//
//  Created by Honghua Li on 2014-11-19.
//  Copyright (c) 2014 SFU. All rights reserved.
//

#import "InstructionDetailViewController.h"

@interface InstructionDetailViewController ()

@end

@implementation InstructionDetailViewController
@synthesize navbar;
@synthesize titleContents;
@synthesize subtitleContents;
@synthesize titleName;
@synthesize subtitlename;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = titleContents;
    self.subtitlename.text = subtitleContents;
    //self.navbar.items = self.titleContents;
    self.detail.editable = NO;
    [self showImageLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//match the image and text with title
-(void)showImageLabel{
    
    if ([self.titleContents isEqualToString:@"Wall Push Up"]) {
        
        self.image = [UIImage imageNamed:@"WallPushUp2.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: Wall push-ups are perfect for a beginner, but all levels benefit from this exercise. Although traditional push-ups work the chest, arms, and shoulders, wall push-ups are an excellent alternative for beginners who want to build strength to get to a more advanced level. Wall push-ups are also a good choice if you want to strengthen the chest but have back problems, because they put no stress on your spine.";
    }
    else if([self.titleContents isEqualToString:@"Sit Up"]){
        
        self.image = [UIImage imageNamed:@"SitUp2.png"];
        self.pos.image = self.image;
        self.detail.text =@"Introduction: The sit-up is an abdominal strength training exercise commonly performed to strengthen the abdominal muscles. It is similar to a crunch (crunches target the rectus and also work the oblique’s), but sit-ups have a fuller range of motion and condition additional muscles. Sit-ups target the hip flexors, rectus abdominus and also work the iliopsoas, tensor fasciae latae, rectus femoris, sartorius, and, to a very small degree, the obliques ";
        
    }
    else if([self.titleContents isEqualToString:@"Quadruped Leg Lift"]){
        
        self.image = [UIImage imageNamed:@"QuadrupedLegLift3.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: The quadruped leg lift is a warm-up and core stabilization exercise that strengthens the entire abdominal region in addition to the gluteus and hamstrings.";
        
    }
    else if([self.titleContents isEqualToString:@"Push Up"]){
        
        self.image = [UIImage imageNamed:@"PushUp1.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: Push-ups are a total-body functional move that's great for increasing strength, much like bench-pressing, and have the added benefit of engaging the core and lower body (thanks, gravity!). The bodyweight exercise can be done just about anywhere — with a ton of variations to liven things up. “So let’s drop down and do the perfect push-up” ";
        
    }
    else if([self.titleContents isEqualToString:@"Shoulder Bridge"]){
        
        self.image = [UIImage imageNamed:@"ShoulderBridge3.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: Shoulder Bridge is an intermediate - advanced Pilate’s exercise. It requires a lot of strength from the abdominals and hamstrings as they stabilize a lifted pelvis against the movement of a fully extended leg ";
        
    }
    else if([self.titleContents isEqualToString:@"Squat"]){
        
        self.image = [UIImage imageNamed:@"Squat2.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: Shoulder Bridge is an intermediate - advanced Pilate’s exercise. It requires a lot of strength from the abdominals and hamstrings as they stabilize a lifted pelvis against the movement of a fully extended leg ";
        
    }
    else if([self.titleContents isEqualToString:@"T Push Up"]){
        
        self.image = [UIImage imageNamed:@"TPushUp2.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: T- Push up helps you improve your overall shoulder health, posture, and core strength. Most people tend to focus too much on front pressing movements without paying enough attention to the rear deltas and upper back pulling movements - the t-push-up is a great movement for working shoulder stabilizer muscles and giving a balanced workload to the entire shoulder.";
        
    }
    else if([self.titleContents isEqualToString:@"Single Leg Deadlift"]){
        
        self.image = [UIImage imageNamed:@"SingleLeglift3.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: Single leg deadlift is unique in that it allows you to fully appreciate the beauty of learning how to stabilize on one leg, while training each side of your body without favoring or over-compensating. It also teaches you an impressive array of skills. Right from the start you learn how to root your bare foot to the ground and hinge in a pattern that fires up the entire posterior chain ";
        
    }
    else if([self.titleContents isEqualToString:@"Lunge"]){
        
        self.image = [UIImage imageNamed:@"Lunge2.png"];
        self.pos.image = self.image;
        self.detail.text = @"Introduction: The lunge is known for helping runners avoid injury when used as a warm-up, strengthening the hammiest and quads, improving lower limb function, and even improving running speed. Since there are many variations, it’s nearly impossible to get bored with them. “So say bye-bye to that fitness plateau and get started with this round-up of lunges” ";
        
    }
    

}


@end
