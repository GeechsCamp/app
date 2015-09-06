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

#import "DownloadView.h" //TODO: あとで消す

@interface ViewController ()
{
    CGSize screenFrame;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedItems];

    // ボタンを描画
    [self ShowItemButton];
    
    
    screenFrame = self.view.bounds.size;
    _motionManager = [[CustomMotionManager alloc] init];
    [self setupAccelerometer];
    
    CGRect rect = CGRectMake(0, 0, screenFrame.width/2, screenFrame.height/2);
    [self MakeShowUILabels:rect];
    
    //※※ダウンロード用
    
     //これをダウンロードボタンおしたときに呼び出す
    /*
     [DownLoadSoundZipData downloadZipData:@"1"]; //引数にサウンドIDを指定
     */
    
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
        _motionManager.accelerometerUpdateInterval = 0.5f;
        [_motionManager setUpHandler:self];
        
        // 加速度の取得開始
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:[_motionManager handler]];
    }
    
}

-(void)setSelectedItems {
    // 選択されている楽器を読み込む
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults dataForKey:@"use_items"] != nil) {
        self.use_items_top = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults dataForKey:@"use_items"]];
    } else {
        // 初回起動時はデフォルト値を保存
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @0,@"1",
                                    @1,@"2",
                                    @2,@"3",
                                    nil];
        self.use_items_top = dic;
        [defaults setObject:dic forKey:@"use_items"];
        [defaults synchronize];
    }
    
    //今鳴る楽器を呼ぶ
    if ([defaults dataForKey:@"selected_item"] != nil) {
        self.selected_item = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults dataForKey:@"selected"]];
    } else {
        // 初回起動時はデフォルト値を保存
        NSNumber *selected_item = @1;
        self.selected_item = selected_item;
        [defaults setObject:selected_item forKey:@"selected_item"];
        [defaults synchronize];
    }

}

-(void)tapItem_1:(id)sender {[self tapItemAction:1];}
-(void)tapItem_2:(id)sender {[self tapItemAction:2];}
-(void)tapItem_3:(id)sender {[self tapItemAction:3];}

-(void)tapItemAction:(NSInteger)index {
    // 押されたボタンを光らせる
    
    // 選択されたデータを変更

}


// あとで消す
- (NSMutableArray *)returnDummyData {
    
    // 楽器データ APIでもらう
    NSDictionary *data01 = [NSDictionary dictionaryWithObjectsAndKeys:
                            @0,@"id",
                            @"handbell_01",@"name",
                            @"ハンドベルです",@"detail",
                            @"0",@"category_id",
                            @"http://img.svgeps.com/clip2/nwn22gri0zm.png",@"image_url",
                            @0,@"del_flg",
                            @000,@"created_date",
                            @000,@"updated_date",
                            nil];
    NSDictionary *data02 = [NSDictionary dictionaryWithObjectsAndKeys:
                            @1,@"id",
                            @"handbell_02",@"name",
                            @"ハンドベルですお",@"detail",
                            @"1",@"category_id",
                            @"http://www.brass.co.jp/images/item/650190.jpg",@"image_url",
                            @0,@"del_flg",
                            @000,@"created_date",
                            @000,@"updated_date",
                            nil];
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:data01];
    [datas addObject:data02];
    return datas;
}

-(UIImage *)returnImage:(NSString *)url_string {
    // キャッシュあったらそこから読み込むよ
    NSURL *url = [NSURL URLWithString:url_string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    // キャッシュしてないならするよ
    return image;
}


@end
