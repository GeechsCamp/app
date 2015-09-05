//
//  DownLoadSoundZipData.h
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSZipArchive.h"
#import <AFHTTPSessionManager.h>


typedef void (^SUCCESS)(BOOL success);
typedef void (^FAIL)(BOOL fail);

@interface DownLoadSoundZipData : NSObject

+(void)downloadZipData:(NSString*)soundId ;


@end
