//
//  CostomAnimationManager.h
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CostomAnimationManager : NSObject

@property(nonatomic,weak) UIView* targetView;


-(void)targetView:(UIView*)view;
-(void)actEffect;
+ (CostomAnimationManager *)sharedManager;
+ (int)getRandomIntWithMin:(int)min Max:(int)max;

@end
