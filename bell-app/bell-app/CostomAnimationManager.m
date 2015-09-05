//
//  CostomAnimationManager.m
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "CostomAnimationManager.h"
#import "CostomAnimationView.h"

@implementation CostomAnimationManager{
    
    NSMutableArray* effectViews;

}

static CostomAnimationManager *sharedData_ = nil;
const int EFFECT_NUMBERS = 12;

-(void)targetView:(UIView*)view{
    

    self.targetView = view;
    
}

-(void)actEffect{
    
    //エフェクトスタイルの決定
    
    //Effect格納Array
    effectViews = nil;
    effectViews = [NSMutableArray array];
    
    for(int i=0; i < EFFECT_NUMBERS;i++){
        
        CostomAnimationView* view = [[CostomAnimationView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        CGFloat position_x = [CostomAnimationManager getRandomIntWithMin:0 Max:self.targetView.frame.size.width];
        CGFloat position_y = [CostomAnimationManager getRandomIntWithMin:0 Max:self.targetView.frame.size.height];
        view.center = CGPointMake(position_x,position_y);
        //view.image = [UIImage imageNamed:@"test.jpg"];
        view.image = [CostomAnimationView imageWithColor:[CostomAnimationManager getColorOne]];
        [self.targetView addSubview:view];
        [effectViews addObject:view];
    
    }
    
    [effectViews makeObjectsPerformSelector:@selector(performEffect)];
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:1.0f];
    [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
    [animation setType:@"rippleEffect" ];
    [self.targetView.layer addAnimation:animation forKey:NULL];

}

+ (int)getRandomIntWithMin:(int)min Max:(int)max {
    
    return min + arc4random() % (max-min+1);
    
}

+ (CostomAnimationManager *)sharedManager{
    
    @synchronized(self){
        
        if (!sharedData_) {
            sharedData_ = [CostomAnimationManager new];
        }
        
    }
    return sharedData_;
}

+(UIColor*)getColorOne{
    
    UIColor* result = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
    
    int randomSelect = [CostomAnimationManager getRandomIntWithMin:1 Max:6];
    
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
