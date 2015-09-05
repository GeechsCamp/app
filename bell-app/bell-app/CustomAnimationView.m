//
//  CostomImageView.m
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "CustomAnimationView.h"
#import "CustomAnimationManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomAnimationView

const int EFFECT_MAX_SIZE = 200;
const int EFFECT_MIN_SIZE = 50;

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
    
}

-(id)init{
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
    
}


-(int)SetRandomAnimationList{
    int a[4] =   {
        UIViewAnimationOptionTransitionFlipFromBottom,
        UIViewAnimationOptionTransitionFlipFromLeft,
        UIViewAnimationOptionTransitionFlipFromRight,
        UIViewAnimationOptionTransitionFlipFromTop,
    };
    
    int random = [CustomAnimationManager getRandomIntWithMin:0 Max:3];
    int result = a[random];
    
    return result;
}

-(void)performEffect{
    
    //[CATransaction flush];
    [UIView transitionWithView:self
                      duration:1.0f
                       options:[self SetRandomAnimationList]//UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
   
                        CGFloat size = [CustomAnimationManager getRandomIntWithMin:EFFECT_MIN_SIZE Max:EFFECT_MAX_SIZE];
                        self.frame = CGRectMake(self.frame.origin.x - size/2, self.frame.origin.y - size / 2, size, size);
    
                    }
                    completion:^(BOOL finished){
                        [self afterEffect];
                    }];
    
}

-(void)afterEffect{
    
    if(self.frame.size.width != 0){
        
        [UIView animateWithDuration:0.1f
                         animations:^{
                             CGFloat origin_x = self.frame.origin.x;
                             CGFloat origin_y = self.frame.origin.y;
                             self.frame = CGRectMake(origin_x+self.frame.size.width/2, origin_y+self.frame.size.height/2, 0, 0);
                         }
                         completion:^(BOOL finished){
                             [self removeFromSuperview];
                         }];
    }

}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 300.0f, 300.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGRect borderRect = CGRectMake(0.0, 0.0, 300.0f, 300.0f);
    CGFloat lineWidth = 2;
   
    //省略でFill
    borderRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 2.0);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    
}


- (void) ViewAnimationDidStop {
    [self removeFromSuperview];
}

@end
