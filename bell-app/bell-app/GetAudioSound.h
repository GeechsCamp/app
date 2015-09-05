//
//  GetAudioSound.h
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAudioSound : NSObject

+(NSURL*)getSoundURL :(NSString*)soundID MP3Num:(NSString*)mp3Number;

@end
