//
//  GetAudioSound.m
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "GetAudioSound.h"

@implementation GetAudioSound

//端末内に保存したmp3ファイルのURLを取得する
+(NSURL*)getSoundURL :(NSString*)soundID MP3Num:(NSString*)mp3Number{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirPath = [paths objectAtIndex:0];
    NSString* path = [NSString stringWithFormat:@"%@/Resources",cachesDirPath];
    NSString* soundPath = [NSString stringWithFormat:@"%@/%@/%@.mp3",path,soundID,mp3Number];
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    
    return url;
    
}



@end
