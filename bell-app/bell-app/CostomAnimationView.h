//
//  CostomImageView.h
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomAnimationView : UIImageView

typedef enum : NSInteger {
    NONE = 0,
    FLIP_LEFT = 1,
    FLIP_RIGHT =  2,
    CURL_UP = 3,
    CURLDOWN =  4,
    PAGE_CURL = 101,
    PAGE_UNCURL = 102,
    SUCK_EFFECT = 103,
    CAMERA_IRIS = 105,
    CAMERA_TRIS_HOLLOW_CLOSE = 106,
    CAMERA_TRIS_HOLLOW_OPEN = 107,
    RIPPLE_EFFET = 110,
    APPLICATION_SUSPEND = 117
} AnimationStyle;

-(void)setAnimationAndStart:(AnimationStyle)style;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
