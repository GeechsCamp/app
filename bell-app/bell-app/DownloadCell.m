//
//  DownloadCell.m
//  bell-app
//
//  Created by M-025 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "DownloadCell.h"
#import <MagicalRecord.h>
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"

@implementation DownloadCell


//- (void)setDataOfRow:(NSDictionary *)dataOfRow {
-(void)setDataOfRow:(Instruments*)instrument {
    
//    [self initFont];
    
    self.download.contentMode = UIViewContentModeScaleAspectFit;
    self.download.enabled = NO;
    
    self.nameLabel.text = instrument.name;
    //self.descriptionLabel.text = instrument.detail;
    self.categoryLabel.text = instrument.category_name;
    self.categoryLabel.textColor = [UIColor grayColor];
    
    // 使用中の楽器dicのidと照合してif分岐
    NSUserDefaults* ud =[NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [ud objectForKey:@"use_items"];
    int i;
    for(i=1; i <= dic.count; i++) {
        NSString* key = [NSString stringWithFormat:@"%d",i];
        NSString* settingID = [NSString stringWithFormat:@"%@",[dic objectForKey:key]];
        NSString* instrument_id = instrument.id;
        NSLog(@"%@",settingID);
        NSLog(@"%@",instrument_id);
        
        if([settingID isEqualToString:instrument_id]) {
            self.statusLabel.text = @" now setting ";
        }
    }
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.backgroundColor = [UIColor redColor];
    

    // カテゴリDBと照合して表示(色も変える?)
    
    // 画像の表示 SDWebimage的処理したい
//    [self.image setImageWithURL:[NSURL URLWithString:dataOfRow[@"image_url"]]];
//    UIImageView *test;
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:instrument.image_url]
                                                    options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      
                                                      self.image.image = image;
                                                      
                                                  }];
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:instrument.image_url];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *image = [[UIImage alloc] initWithData:data];
    
   // self.image.image = image;
    
//    [self.image setImageWithURL:[NSURL URLWithString:@"http://img.svgeps.com/clip2/nwn22gri0zm.png"]];

    
    
    // downloadボタンの分岐表示
}


- (void)download:(id)sender {
    // TODO:くるくる入れる
    
    
    // ダウンロード済がわかるように
    //self.download.alpha = 0.2;
    
    // ローカルデータにダウンロード済idを追加
    
    // zipファイルをダウンロード&解凍して格納
}




- (void)useitem:(id)sender {
    // 使用中のidを格納
    // statusの値をかきかえ
}

@end
