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

@property (nonatomic,retain)NSMutableDictionary*use_items_top;
@property (nonatomic,retain)NSNumber* selected_item;

@property (weak, nonatomic) IBOutlet UIButton *item_1;
- (IBAction)tapItem_1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *item_2;
- (IBAction)tapItem_2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *item_3;
- (IBAction)tapItem_3:(id)sender;

@end

