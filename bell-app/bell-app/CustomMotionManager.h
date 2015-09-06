//
//  CustomMotionManager.h
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/06.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@protocol CustomMotionDelegate <NSObject>

@required

-(void)refleshXYZ:(double) xac y:(double) yac z:(double) zac;
-(void)playSound:(NSURL*)url;
-(void)stopSoundAFterDeley:(float)time;

@end

@interface CustomMotionManager : CMMotionManager

@property (nonatomic,weak) id<CustomMotionDelegate> delegate;

-(void)setUpHandler:(id)target;

@end
