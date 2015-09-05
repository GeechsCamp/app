//
//  RecognizePhoneWave.m
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "RecognizePhoneWave.h"

@implementation RecognizePhoneWave



//南蛮の音を鳴らすか音の番号を返す
+(int)DecideSoundbyWave:(float)xPoint Y:(float)yPoint Z:(float)zPoint {

    
    if(xPoint < -0.5f && yPoint < -0.9f){
        return  1;
        
    }
    
    if(xPoint < -0.5f && (yPoint < -0.1f && yPoint > -0.9f)){
        return  2;
        
    }
    
    if (xPoint < -0.5f && (yPoint > -0.1f)) {
        return  3;
    }
    
    return 0;
}



@end
