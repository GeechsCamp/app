//
//  ViewController.h
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AFNetworking.h>
#import "RecognizePhoneWave.h"

@interface ViewController : UIViewController

@property (nonatomic,retain)CMMotionManager *motionManager;
@property (nonatomic,retain)UILabel* xLabel;
@property (nonatomic,retain)UILabel* yLabel;
@property (nonatomic,retain)UILabel* zLabel;
@property (nonatomic,retain)AVAudioPlayer* audioPlayer;

@end

