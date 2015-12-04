//
//  LevelDocument.h
//  Login
//
//  Created by Yu-Chun Lin on 2014-10-31.
//  Copyright (c) 2014 GOFit Apple(Group 2) All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelDocument : NSObject

@property (nonatomic) NSString* Stars_1;
@property (nonatomic) NSString* Stars_2;
@property (nonatomic) NSString* Stars_3;
@property (nonatomic) NSString* a_score_1;
@property (nonatomic) NSString* c_score_1;
@property (nonatomic) NSString* l_score_1;
@property (nonatomic) NSString* a_score_2;
@property (nonatomic) NSString* c_score_2;
@property (nonatomic) NSString* l_score_2;
@property (nonatomic) NSString* a_score_3;
@property (nonatomic) NSString* c_score_3;
@property (nonatomic) NSString* l_score_3;

@property (nonatomic) BOOL isNewExerciseUser;
-(void) saveExerciseRecord;
- (void) fetchExerciseRocord;
-(void) compareTwoScore: (int)level andBodyPart:(NSString*)part andCurrentScore: (int)score;


+ (LevelDocument *)sharedLevelDocument;


@end
