//
//  CustomMotionManager.h
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/06.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#include <AVFoundation/AVFoundation.h>

@protocol CustomMotionDelegate <NSObject>

@required

-(void)refleshXYZ:(double) xac y:(double) yac z:(double) zac;

@end

@interface CustomMotionManager : CMMotionManager<AVAudioPlayerDelegate>

@property (nonatomic,weak) id<CustomMotionDelegate> delegate;
@property (nonatomic,retain)AVAudioPlayer* audioPlayer;

-(void)setUpHandler:(id)target;
-(CMAccelerometerHandler)handler;

@end
