//
//  CostomAnimationManager.m
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "CustomAnimationManager.h"
#import "CustomAnimationView.h"

@implementation CustomAnimationManager{
    
    NSMutableArray* effectViews;
    NSArray* TransitionArray;

}

static CustomAnimationManager *sharedData_ = nil;
const int EFFECT_NUMBERS = 12;

-(void)initialize{
    
    TransitionArray = @[
//              @"flip",
//              @"alignedFlip",
//              @"oglFlip",
//              @"rotate",
//              @"pageCurl",
//              @"pageUnCurl",
            @"rippleEffect",
//              @"suckEffect"
              ];
    


}

-(void)targetView:(UIView*)view{
    

    self.targetView = view;
    //[self setEffectViews];
    
}


-(void)actEffect{
    
    int effectMode = 1;
    
    //エフェクトスタイルの決定
    
    //Effect格納Array
    effectViews = nil;
    effectViews = [NSMutableArray array];
    
    for(int i=0; i < EFFECT_NUMBERS;i++){
        
        CustomAnimationView* view = [[CustomAnimationView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        CGFloat position_x = [CustomAnimationManager getRandomIntWithMin:0 Max:self.targetView.frame.size.width];
        CGFloat position_y = [CustomAnimationManager getRandomIntWithMin:0 Max:self.targetView.frame.size.height];
        view.center = CGPointMake(position_x,position_y);
        //view.image = [UIImage imageNamed:@"test.jpg"];
        view.image = [CustomAnimationView imageWithColor:[CustomAnimationManager getColorOne]];
        [self.targetView addSubview:view];
        [view setNeedsDisplay];
        [effectViews addObject:view];
    
    }
    
    [effectViews makeObjectsPerformSelector:@selector(performEffect)];
    
    if(effectMode){
        NSString* randomTransition = [TransitionArray objectAtIndex:[CustomAnimationManager getRandomIntWithMin:0 Max:(int)(TransitionArray.count-1)]];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:randomTransition];
        //[CATransaction flush];
        [self.targetView.layer addAnimation:animation forKey:NULL];
//        for (CostomAnimationView* views in effectViews) {
//            [CATransaction flush];
//            [views.layer addAnimation:animation forKey:NULL];
//        }
    }

}

+ (int)getRandomIntWithMin:(int)min Max:(int)max {
    
    return min + arc4random() % (max-min+1);
    
}

+ (CustomAnimationManager *)sharedManager{
    
    @synchronized(self){
        
        if (!sharedData_) {
            sharedData_ = [CustomAnimationManager new];
            [sharedData_ initialize];
        }
        
    }
    return sharedData_;
}

+(UIColor*)getColorOne{
    
    UIColor* result = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
    
    int randomSelect = [CustomAnimationManager getRandomIntWithMin:1 Max:6];
    
    switch (randomSelect) {
        case 1:
            result = [UIColor colorWithRed:0.8 green:0.17 blue:0.28 alpha:1];
            break;
        case 2:
            result = [UIColor colorWithRed:0.29 green:0.53 blue:0.74 alpha:1];
            break;
        case 3:
            result = [UIColor colorWithRed:0.89 green:0.19 blue:0.14 alpha:1];
            break;
        case 4:
            result = [UIColor colorWithRed:0.37 green:0.11 blue:0.48 alpha:1];
            break;
        case 5:
            result = [UIColor colorWithRed:0.43 green:0.77 blue:0.15 alpha:1];
            break;
        case 6:
            result = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
            break;
        default:
            result = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
            break;
    }
    
    return result;

}



@end
