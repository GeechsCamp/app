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
#import <MagicalRecord.h>

@interface ViewController ()
{
    CGSize screenFrame;
    UIView* motionScreen;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    motionScreen = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:motionScreen];
    [[CustomAnimationManager sharedManager] setTargetView:motionScreen];
    
    CGRect rect = CGRectMake(0, 0, screenFrame.width/2, screenFrame.height/2);
    [self MakeShowUILabels:rect];
    
    screenFrame = self.view.bounds.size;
    _motionManager = [[CustomMotionManager alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setSelectedItems];
    
    // ボタンを描画
    [self ShowItemButton];
    
    [self setupAccelerometer];
    

}

-(void)ShowItemButton {
    // 画像を呼ぶ
    NSDictionary *use_items = self.use_items_top;
    Instruments *item_1 = [Instruments MR_findFirstByAttribute:@"id" withValue:use_items[@"1"]];
    Instruments *item_2 = [Instruments MR_findFirstByAttribute:@"id" withValue:use_items[@"2"]];
    Instruments *item_3 = [Instruments MR_findFirstByAttribute:@"id" withValue:use_items[@"3"]];
    
    [self.item_1 setImage:[self returnImage:item_1.image_url] forState:UIControlStateNormal];
    [self.item_2 setImage:[self returnImage:item_2.image_url] forState:UIControlStateNormal];
    [self.item_3 setImage:[self returnImage:item_3.image_url] forState:UIControlStateNormal];
    
    // 選択されてるやつは光る
    if ([self.selected_item isEqual:@"1"]) [self.item_1 setBackgroundColor:[UIColor yellowColor]];
    if ([self.selected_item isEqual:@"2"]) [self.item_2 setBackgroundColor:[UIColor yellowColor]];
    if ([self.selected_item isEqual:@"3"]) [self.item_3 setBackgroundColor:[UIColor yellowColor]];
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

-(void)refleshXYZ:(double) xac y:(double) yac z:(double) zac{

    // 画面に表示
    self.xLabel.text = [NSString stringWithFormat:@"x: %f", xac];
    self.xLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    self.yLabel.text = [NSString stringWithFormat:@"y: %f", yac];
    self.yLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    self.zLabel.text = [NSString stringWithFormat:@"z: %f", zac];
    self.zLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
}

- (void)setupAccelerometer{
    if (_motionManager.accelerometerAvailable){
        // センサーの更新間隔の指定
        _motionManager.accelerometerUpdateInterval = 0.02f;
        [_motionManager setUpHandler:self];
        
        // 加速度の取得開始
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:[_motionManager handler]];
    }
    
}

-(void)setSelectedItems {
    // 選択されている楽器を読み込む
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"use_items"] != nil) {
        NSDictionary* dic = [defaults objectForKey:@"use_items"];
        self.use_items_top = [dic mutableCopy];
    } else {
        // 初回起動時はデフォルト値を保存
        NSDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @0,@"1",
                                    @1,@"2",
                                    @2,@"3",
                                nil];
        self.use_items_top = [dic mutableCopy];
        [defaults setObject:dic forKey:@"use_items"];
        [defaults synchronize];
    }
    
    //今鳴る楽器を呼ぶ
    if ([defaults objectForKey:@"selected_item"] != nil) {
        self.selected_item = [defaults objectForKey:@"selected"];
    } else {
        // 初回起動時はデフォルト値を保存
        NSString *selected_item = @"1";
        self.selected_item = selected_item;
        [defaults setObject:selected_item forKey:@"selected_item"];
        [defaults synchronize];
    }
}

-(void)tapItem_1:(id)sender {[self tapItemAction:@"1"];}
-(void)tapItem_2:(id)sender {[self tapItemAction:@"2"];}
-(void)tapItem_3:(id)sender {[self tapItemAction:@"3"];}

-(void)tapItemAction:(NSString *)index {
    self.selected_item = [self.use_items_top objectForKey:index];
    [_motionManager setSelectedItem:self.selected_item];
    // selected_itemが選択されているsoundId
    
    // 選択されたデータを変更
    // self.selected_item(string) が選んでる番号
}



-(UIImage *)returnImage:(NSString *)url_string {
    // キャッシュあったらそこから読み込むよ
    NSURL *url = [NSURL URLWithString:url_string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    // キャッシュしてないならするよ
    return image;
}

- (BOOL)canBecomeFirstResponder

{
    
    return YES;
    
}



- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
        
    {
        
        NSLog(@"Motion began");
        [[CustomAnimationManager sharedManager] actEffect];
        [_motionManager resetCount];
        
    }
    
}



- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
        
    {
        
        NSLog(@"Motion cancelled");
        [[CustomAnimationManager sharedManager] actEffect];
        [_motionManager resetCount];
        
    }
    
}



- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
        
    {
        
        NSLog(@"Motion end");
        
        [_motionManager actSound];
        [[CustomAnimationManager sharedManager] actEffect];
        [_motionManager resetCount];
        
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [_motionManager stopAccelerometerUpdates];
    
}




@end
