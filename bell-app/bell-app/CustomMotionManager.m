//
//  CustomMotionManager.m
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/06.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "CustomMotionManager.h"
#import "RecognizePhoneWave.h"
#import "GetAudioSound.h"
#import "ViewController.h"

@implementation CustomMotionManager{


    BOOL isPlay;
    CMAccelerometerHandler handler;
    
}

const float SOUNDTIME = 0.5;

-(BOOL)isPLay{
    
    return isPlay;

}

-(void)setUpHandler:(id)target{
    
    self.delegate = target;
    __weak typeof(self)weakself= self;
    
    
    //仮当て
    
    handler = ^(CMAccelerometerData *data, NSError *error){
        
        // 加速度センサー
        double xac = data.acceleration.x;
        double yac = data.acceleration.y;
        double zac = data.acceleration.z;
        
        //画面更新
        [weakself.delegate refleshXYZ:xac y:yac z:zac];

        //３つあるうちのどの音を出すかを判別する数字を取得（上:1,中:2,下:3)
        int soundRecognizeNum = [RecognizePhoneWave DecideSoundbyWave:xac Y:yac Z:zac];
        
        //サウンドIDの取得
        NSString* soundid = @"1";
        
        //位置に合わせて出す音を分ける
        if([weakself isPLay]){

            return;
            
        }else{

            isPlay = true;
            [weakself.delegate stopSoundAFterDeley:SOUNDTIME];
            NSURL* soundUrl = [GetAudioSound getSoundURL:soundid MP3Num:[[NSNumber numberWithUnsignedInt:soundRecognizeNum] stringValue]];
            [weakself.delegate playSound:soundUrl];
            
        }
        
    };


}

@end
