//
//  RecognizePhoneWave.h
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecognizePhoneWave : NSObject


+(int)DecideSoundbyWave:(float)xPoint Y:(float)yPoint Z:(float)zPoint;

@end
