//
//  ViewController.m
//  bell-app
//
//  Created by VCJPCM012 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadSoundZipData.h"
#import "GetAudioSound.h"
#import <AFHTTPRequestOperation.h>

@interface ViewController ()
{
    CGSize screenFrame;
    BOOL isPlay;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenFrame = self.view.bounds.size;
    _motionManager = [[CMMotionManager alloc] init];
    [self setupAccelerometer];
    
    CGRect rect = CGRectMake(0, 0, screenFrame.width/2, screenFrame.height/2);
    [self MakeShowUILabels:rect];
    
    //※※ダウンロード用
    
     //これをダウンロードボタンおしたときに呼び出す
     [DownLoadSoundZipData downloadZipData:@"1"]; //引数にサウンドIDを指定
    
}





-(void)MakeShowUILabels:(CGRect)rect{
    
    _xLabel = [[UILabel alloc]initWithFrame:rect];
    _xLabel.center = CGPointMake(screenFrame.width/2, 100);
    [self.view addSubview:_xLabel];
    
    _yLabel = [[UILabel alloc]initWithFrame:rect];
    _yLabel.center = CGPointMake(screenFrame.width/2, 180);
    [self.view addSubview:_yLabel];
    
    _zLabel = [[UILabel alloc]initWithFrame:rect];
    _zLabel.center = CGPointMake(screenFrame.width/2, 240);
    [self.view addSubview:_zLabel];
    
}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    isPlay = NO;
    
}


- (void)setupAccelerometer{
    if (_motionManager.accelerometerAvailable){
        // センサーの更新間隔の指定
        _motionManager.accelerometerUpdateInterval = 0.5f;
        
        // ハンドラを設定
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error)
        {
            // 加速度センサー
            double xac = data.acceleration.x;
            double yac = data.acceleration.y;
            double zac = data.acceleration.z;
            
            
            //最初のxyzのデフォルト値を取得
            
            
            // 画面に表示
            self.xLabel.text = [NSString stringWithFormat:@"x: %f", xac];
            self.xLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
            self.yLabel.text = [NSString stringWithFormat:@"y: %f", yac];
            self.yLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
            self.zLabel.text = [NSString stringWithFormat:@"z: %f", zac];
            self.zLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
            
            //３つあるうちのどの音を出すかを判別する数字を取得（上:1,中:2,下:3)
            int soundRecognizeNum = [RecognizePhoneWave DecideSoundbyWave:xac Y:yac Z:zac];
            
            //サウンドIDの取得
            NSString* soundid = @"1";
            
            //位置に合わせて出す音を分ける
            if(isPlay){
                return;
                
            }else if (soundRecognizeNum == 1) {
                isPlay = true;
                
                [self performSelector:@selector(changeisPlayNO) withObject:nil afterDelay:0.5f];
                
                NSURL* soundUrl = [GetAudioSound getSoundURL:soundid MP3Num: @"1"];
                [self playSound:soundUrl];
                
                
            }else if (soundRecognizeNum == 2) {
                isPlay = true;
                [self performSelector:@selector(changeisPlayNO) withObject:nil afterDelay:0.5f];
                
                NSURL* soundUrl = [GetAudioSound getSoundURL:soundid MP3Num: @"2"];
                [self playSound:soundUrl];
                
                
            }else if (soundRecognizeNum == 3) {
                isPlay = true;
                [self performSelector:@selector(changeisPlayNO) withObject:nil afterDelay:0.5f];
                
                NSURL* soundUrl = [GetAudioSound getSoundURL:soundid MP3Num: @"3"];
                [self playSound:soundUrl];
            }
        };
        
        // 加速度の取得開始
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    }
    
}

-(void)changeisPlayNO {
    isPlay = NO;
}

//音楽演奏用
-(void)playSound:(NSURL*)soundUrl {
    
    NSError* error = nil;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:&error];
    
    if(error){
        return;
    }
    _audioPlayer.delegate = self;
    [_audioPlayer play];
    
    isPlay = YES;
}


@end
