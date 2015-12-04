//
//  GFACoreMotion.m
//  Musclapp
//
//  Created by Davidson Kao on 2014-10-24.
//  Copyright (c) 2014 Gofit App. All rights reserved.
//

#import "GFACoreMotion.h"



@interface GFACoreMotion ()
@property (strong, nonatomic) NSMutableArray * accelArray;
@end




@implementation GFACoreMotion
@synthesize _maneger;
/*
 @synthesize accelerationx;
 @synthesize accelerationy;
 @synthesize accelerationz;
 @synthesize velocityx;
 @synthesize velocityy;
 @synthesize velocityz;
 @synthesize distancex;
 @synthesize distancey;
 @synthesize distancez;
 */

double startAngleYaw, startAnglePitch, startAngleRoll;
double currentAngleYaw, currentAnglePitch, currentAngleRoll;
double repXDistance, repYDistance, repZDistance;
double totalXDistance, totalYDistance, totalZDistance;

double TD = 0;
NSUInteger Rep = 0;

#define TIME_INTERVAl 1/35
#define G 9.81
#define DISTANCE_CONVERTER(x) x*TIME_INTERVAl*TIME_INTERVAl*G*100
#define degrees(x) (180 * x / M_PI)


// Accelerometer portion
- (void) startAccelMotionMoniteringWithLevel:(int)level andPart:(NSString*) part// andThread: (NSThread*) thread//might merge giroscope and accelerometer parts
{
    [self reset];
    NSLog(@"has made it into start accelermeter\n");
    self._maneger =[[CMMotionManager alloc] init];
    
    if (self._maneger.accelerometerAvailable)
    {
        
        NSTimeInterval timeinterval = TIME_INTERVAl;
        //self._maneger.accelerometerUpdateInterval = timeinterval;
        self._maneger.deviceMotionUpdateInterval = timeinterval;
        [self gyroDataPushWithYaw:&startAngleYaw andPitch:&startAnglePitch andRoll:&startAngleRoll];
        //[self._maneger startAccelerometerUpdates];
        [self._maneger startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (!error)
            {
                /*                bool iscancled = [thread isCancelled];
                 if (iscancled)
                 {
                 [NSThread exit];
                 }*/
                double userX = motion.userAcceleration.x*G;
                double userY = motion.userAcceleration.y*G;
                double userZ = motion.userAcceleration.z*G;
                NSLog(@"x: %.2f   y: %.2f   z: %.2f", userX, userY, userZ);
                if (userX > 10 || userX < -10)
                {
                    userX = 0;
                }
                if (userY > 10 || userY < -10)
                {
                    userY = 0;
                }
                if (userZ > 10 || userZ < -10)
                {
                    userZ = 0;
                }
                [self gyroDataPushWithYaw:&currentAngleYaw andPitch:&currentAnglePitch andRoll:&currentAngleRoll];
                [self RepetitionCounterWithAccelerometerDataX:userX andY:userY andZ:userZ andLevel:level andPart:part];
            }
            else
            {
                NSLog(@"Device Motion Error\n");
            }
        }];
        /* //old
         [self._maneger startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
         if (!error)
         {
         NSLog(@"getting accelerometer data\n");
         double xAccel = accelerometerData.acceleration.x;
         double yAccel = accelerometerData.acceleration.y;
         double zAccel = accelerometerData.acceleration.z;
         [self gyroDataPushWithYaw:&currentAngleYaw andPitch:&currentAnglePitch andRoll:&currentAngleRoll];
         [self RepetitionCounterWithAccelerometerDataX:xAccel andY:yAccel andZ:zAccel andLevel:level andPart:part];
         }
         else
         {
         NSLog(@"Accelerometer Error\n");
         }
         }];
         */
    }
    else
    {
        NSLog(@"No Accelerometer\n");
    }
    
}

//stops acceleromitor updates (supposidly
- (void) stopAccelMotionMonitring
{
    //[self._maneger stopAccelerometerUpdates];
    [self._maneger stopDeviceMotionUpdates];
}

// Giroscope protion //currently unused
- (void) gyroDataPushWithYaw:(double*)yaw andPitch:(double*)pitch andRoll:(double*)roll
{
    if (self._maneger.gyroAvailable)
    {
        NSTimeInterval timeInterval = TIME_INTERVAl;
        self._maneger.gyroUpdateInterval = timeInterval;
        [self._maneger startGyroUpdates];
        *yaw = self._maneger.deviceMotion.attitude.yaw;
        *pitch = self._maneger.deviceMotion.attitude.pitch;
        *roll = self._maneger.deviceMotion.attitude.roll;
        [self stopGiroscopeUpdate];
    }
    else
    {
        NSLog(@"No Giroscope\n");
    }
}

//stops giroscope updates
- (void) stopGiroscopeUpdate
{
    [self._maneger stopGyroUpdates];
}




// Repetition calculating portion
- (void) RepetitionCounterWithAccelerometerDataX:(double)xAccel andY:(double)yAccel  andZ:(double)zAccel andLevel:(int)level andPart:(NSString *)part;
{
    double xDistance, yDistance, zDistance; // in cm since
    
    
    
    if (xAccel < 0)
    {
        xDistance = ceil(DISTANCE_CONVERTER(xAccel));
    }
    else
    {
        xDistance = floor(DISTANCE_CONVERTER(xAccel));
    }
    if(yAccel < 0)
    {
        yDistance = ceil(DISTANCE_CONVERTER(yAccel));
        
    }
    else
    {
        yDistance = floor(DISTANCE_CONVERTER(yAccel));
    }
    if (zAccel < 0)
    {
        zDistance = ceil(DISTANCE_CONVERTER(zAccel));
        
    }
    else
    {
        zDistance = floor(DISTANCE_CONVERTER(zAccel));
    }
    repXDistance += abs(xDistance);
    repYDistance += abs(yDistance);
    repZDistance += abs(zDistance);
    
    
    TD += sqrtf(xDistance*xDistance + yDistance*yDistance + zDistance*zDistance);
    
    if (level == 1)
    {
        if ([part isEqualToString:@"Arm"])
        {
            if (repYDistance >= 72)
            {
                if (repZDistance >= 46)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
        else if ([part isEqualToString:@"Core"])
        {
            //Rep = (int)TD/150;
            if (repYDistance >= 100)
            {
                if (repZDistance >= 140)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
        else if ([part isEqualToString:@"Leg"])
        {
            //Rep = (int)TD/60;
            if (repXDistance >= 70)
            {
                if (repYDistance >= 40)
                {
                    
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
        
    }
    else if (level == 2)
    {
        if ([part isEqualToString:@"Arm"])
        {
            //Rep = (int)TD/60;
            if (repYDistance >= 45)
            {
                if (repZDistance >= 180)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
            
        }
        else if ([part isEqualToString:@"Core"])
        {
            //Rep = (int)TD/60;
            if (repXDistance >= 90)
            {
                if (repYDistance >= 48)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
        else if ([part isEqualToString:@"Leg"])
        {
            //Rep = (int)TD/100;
            
            if (repYDistance >= 520)
            {
                Rep++;
                repXDistance = 0;
                repYDistance = 0;
                repZDistance = 0;
            }
            
        }
        
    }
    else if (level == 3)
    {
        if ([part isEqualToString:@"Arm"])
        {
            //Rep = (int)TD/240;
            if (repYDistance >= 90)
            {
                if (repZDistance >= 210)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
            
        }
        else if ([part isEqualToString:@"Core"])
        {
            //Rep = (int)TD/60;
            if (repXDistance >= 140)
            {
                if (repYDistance >= 56)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
        else if ([part isEqualToString:@"Leg"])
        {
            //Rep = (int)TD/140;
            if (repXDistance >= 180)
            {
                if (repYDistance >= 102)
                {
                    Rep++;
                    repXDistance = 0;
                    repYDistance = 0;
                    repZDistance = 0;
                }
            }
        }
    }
    [self.delegate returnValuesWithReps:Rep andTotalDistance:TD/100]; //convert TD back into meters
}

// to reset whenever a exercise starts or else it will use previous points/ information
- (void) reset
{
    
    TD = 0;
    Rep = 0;
    currentAnglePitch = 0;
    currentAngleRoll =0;
    currentAngleYaw =0;
    repXDistance = 0;
    repYDistance = 0;
    repZDistance = 0;
}

@end
