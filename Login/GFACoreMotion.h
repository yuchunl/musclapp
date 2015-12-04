//
//  GFACoreMotion.h
//  Musclapp
//
//  Created by Davidson Kao on 2014-10-24.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol motion <NSObject>

- (void) returnValuesWithReps:(NSUInteger) rep andTotalDistance: (double) distance;

@end


@interface GFACoreMotion : NSObject


@property (nonatomic, strong)CMMotionManager *_maneger;
@property (nonatomic, strong)id<motion> delegate;
/*
@property (nonatomic, strong)__block NSMutableArray *accelerationx;
@property (nonatomic, strong)__block NSMutableArray *accelerationy;
@property (nonatomic, strong)__block NSMutableArray *accelerationz;
@property (nonatomic, strong)__block NSMutableArray *velocityx;
@property (nonatomic, strong)__block NSMutableArray *velocityy;
@property (nonatomic, strong)__block NSMutableArray *velocityz;
@property (nonatomic, strong)__block NSMutableArray *distancex;
@property (nonatomic, strong)__block NSMutableArray *distancey;
@property (nonatomic, strong)__block NSMutableArray *distancez;
*/


- (void) startAccelMotionMoniteringWithLevel:(int)level andPart:(NSString*) part /*andThread: (NSThread*) thread*/;
- (void) stopAccelMotionMonitring;
@end
