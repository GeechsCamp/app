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

    CMAccelerometerHandler handler;
    
    UIAccelerationValue gravX;
    UIAccelerationValue gravY;
    UIAccelerationValue gravZ;
    UIAccelerationValue prevVelocity;
    UIAccelerationValue prevAcce;
    
    UIAccelerationValue prevVelocity_y;
    
    int vectorCount;
    
}

//
const float SOUNDTIME = 0.5;

//モーション大小閾値
const int Threshold = 15;
#define kAccelerometerFrequency        50.0 //Hz
#define kFilteringFactor 0.1

-(CMAccelerometerHandler)handler{
    
    return handler;
}

-(void)increaseVectorCount{
    vectorCount++;
}

//音楽演奏用
-(void)playSound:(NSURL*)soundUrl {
    
    NSError* error = nil;
    
    NSData *songFile = [[NSData alloc] initWithContentsOfURL:soundUrl options:NSDataReadingMappedIfSafe error:&error ];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:songFile error:&error];
    
    //_audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:&error];
    
    if(error){
        return;
    }

    _audioPlayer.delegate = self;
    [_audioPlayer play];

}

- (UIAccelerationValue)tendToZero:(UIAccelerationValue)value {
    if (value < 0) {
        return ceil(value);
    } else {
        return floor(value);
    }
}

-(void)setUpHandler:(id)target{
    
    self.delegate = target;
    __weak typeof(self)weakself= self;
    
    gravX = gravY = gravZ = prevVelocity = prevVelocity_y = prevAcce = 0.f;
    vectorCount = 0;
    
    //仮当て
    
    handler = ^(CMAccelerometerData *data, NSError *error){
        
        // 加速度センサー
        double xac = data.acceleration.x;
        double yac = data.acceleration.y;
        double zac = data.acceleration.z;
        
        //
        gravX = (xac * kFilteringFactor) + (gravX * (1.0 - kFilteringFactor));
        gravY = (yac * kFilteringFactor) + (gravY * (1.0 - kFilteringFactor));
        gravZ = (zac * kFilteringFactor) + (gravZ * (1.0 - kFilteringFactor));
        
        UIAccelerationValue accelX = xac - ( (xac * kFilteringFactor) + (gravX * (1.0 - kFilteringFactor)) );
        
        UIAccelerationValue accelY = yac - ( (yac * kFilteringFactor) + (gravY * (1.0 - kFilteringFactor)) );
        UIAccelerationValue accelZ = zac - ( (zac * kFilteringFactor) + (gravZ * (1.0 - kFilteringFactor)) );
        accelX *= 9.81f;
        accelY *= 9.81f;
        accelZ *= 9.81f;
        accelX = [self tendToZero:accelX];
        accelY = [self tendToZero:accelY];
        accelZ = [self tendToZero:accelZ];
        
        //UIAccelerationValue vector = accelY;
        UIAccelerationValue vector = sqrt(pow(accelX,2)+pow(accelY,2)+pow(accelZ, 2));
        UIAccelerationValue acce = vector - prevVelocity;
        UIAccelerationValue velocity = (((acce - prevAcce)/2) * (1/kAccelerometerFrequency)) + prevVelocity;
        

        NSLog(@"X %g Y %g Z %g, Vector %g, Velocity %g",accelX,accelY,accelZ,vector,velocity);
        
        if(vector >= 10){
            [weakself increaseVectorCount];
        }
        
        prevAcce = acce;
        prevVelocity = velocity;
        
        //画面更新
        [weakself.delegate refleshXYZ:xac y:yac z:zac];
        
    };


}

-(void)resetCount{
    vectorCount = 0;
}

-(void)actSound{
    
    if(vectorCount >= 15){
        NSLog(@"sound:1 vectorCount = %d",vectorCount);
    }else{
        NSLog(@"sound:2");
    }
    
    //３つあるうちのどの音を出すかを判別する数字を取得（上:1,中:2,下:3)
    //音仮当て
    int soundRecognizeNum = 1;//[RecognizePhoneWave DecideSoundbyWave:xac Y:yac Z:zac];
    
    //サウンドIDの取得
    NSString* soundid = @"1";

    //[self stopSoundAfterDeley:SOUNDTIME];
    NSURL* soundUrl = [GetAudioSound getSoundURL:soundid MP3Num:[[NSNumber numberWithInt:soundRecognizeNum] stringValue]];
    [self playSound:soundUrl];

}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    //isPlay = NO;
    
}

-(void)stopSoundAfterDeley:(float)time{
    
    [self performSelector:@selector(changeisPlayNO) withObject:nil afterDelay:SOUNDTIME];

}

-(void)changeisPlayNO {
    //isPlay = NO;
}



@end
