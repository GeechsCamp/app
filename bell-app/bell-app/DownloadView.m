//
//  DownloadView.m
//  bell-app
//
//  Created by M-025 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "DownloadView.h"
#import "DownloadCell.h"
#import "dummy_data.h"
#import <MagicalRecord.h>
#import "DownLoadSoundZipData.h"
#import "SVProgressHUD.h"


@interface DownloadView ()


@end

@implementation DownloadView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedItems];
    [self CreateAllSoundsLocalData];

}


-(void)saveDownloadedSoundID:(NSString*)soundID{
    
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSArray* savedArray = [ud objectForKey:@"SoundID"];

    NSMutableArray* array = [savedArray mutableCopy];
    if(array == nil) {
        array = [NSMutableArray array];
    }
    [array addObject:soundID];
    savedArray = [array copy];
    
    [ud setObject:savedArray forKey:@"SoundID"];
    [ud synchronize];

}


-(BOOL)getIfDownloadedSoundID :(NSString*)soundID {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSArray* savedArray = [ud objectForKey:@"SoundID"];
    
    int i;
    BOOL alreadyDownloaded = false;
    for(i=0; i<savedArray.count; i++) {
        
        if([[savedArray objectAtIndex:i] isEqualToString:soundID]){
            alreadyDownloaded = YES;
        }
    }
    
    return alreadyDownloaded;
}



-(void)CreateAllSoundsLocalData {
    
    NSURL *url = [NSURL URLWithString:@"http://geechscamp.xyz/gc_instruments/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // データが取得できた場合
    NSArray *jsonArray;
    if (json_data != nil) {
        jsonArray = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"array==%@",jsonArray);
        
    }
    

    int i;
    for(i=0; i < jsonArray.count; i++) {
        
        Instruments* instruments = [Instruments MR_createEntity];
        NSDictionary* dic = [jsonArray objectAtIndex:i];
        
        NSLog(@"%@",[dic objectForKey:@"id"]);
        
        instruments.id = [dic objectForKey:@"id"];
        instruments.category_name  = [dic objectForKey:@"category_name"];
        instruments.image_url = [dic objectForKey:@"image_url"];
        instruments.name = [dic objectForKey:@"name"];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    NSLog(@"ローカルデータ==%@",self.datas);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    NSArray* array = [Instruments MR_findAll];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadCell" forIndexPath:indexPath];
    
    NSArray* array = [Instruments MR_findAll];
    Instruments* instrument = [array objectAtIndex:indexPath.row];
    NSLog(@"名前=%@",instrument.name);
    [cell setDataOfRow:instrument];
    
    if([self getIfDownloadedSoundID:instrument.id]) {
        cell.download.alpha = 0.0f;
        cell.statusLabel.alpha = 1.0f;
    }
    else {
        cell.statusLabel.alpha = 0.0f;
        cell.download.alpha = 1.0f;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray* array = [Instruments MR_findAll];
    Instruments* instrument = [array objectAtIndex:indexPath.row];
    
    _selectedSoundID = instrument.id;
    
    //すでにダウンロード済みかチェック
    BOOL ifAlreadyDownloaded = [self getIfDownloadedSoundID:instrument.id];
    
    if(ifAlreadyDownloaded) {
        
        //たみちゃんの選択アクションシートを表示
        [self showAlertAction:(int)[_selectedSoundID integerValue]];
        
    }
    else { //ダウンロードしてない場合は、ダウンロード確認モーダルを出してダウンロード
        
        NSString* instrumentName = instrument.name;
        NSString* confirmMessage = [NSString stringWithFormat:@"Do you want to download [%@]?",instrumentName];
        _downloadConfirmAlert = [[UIAlertView alloc]initWithTitle:confirmMessage message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [_downloadConfirmAlert show];
    }
    
    _selectedIndexPath = indexPath;

}


-(void)showDownLoadedAlert{
    //アラートビュー
    NSString* message = [NSString stringWithFormat:@"Download Completed!"];
    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}



-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView == _downloadConfirmAlert) {
        __block __weak typeof(self)weakself = self;
        switch (buttonIndex) {
            case 0:
                //キャンセル
                break;
            case 1:
                
                [SVProgressHUD showWithStatus:@"Downloading..." maskType:SVProgressHUDMaskTypeGradient];
                
                //zipダウンロード処理実行
                [DownLoadSoundZipData downloadZipData:_selectedSoundID SUCCESS:^(BOOL success) {
                    
                    [weakself showDownLoadedAlert];
                    //[SVProgressHUD showSuccessWithStatus:@"ロード完了！"];
                    [weakself saveDownloadedSoundID:_selectedSoundID];
                    

                    DownloadCell* cell = (DownloadCell*)[self.tableView cellForRowAtIndexPath:_selectedIndexPath];
                    cell.download.alpha = 0.0f;
                    cell.statusLabel.alpha = 1.0f;
                    
                    
                    //[weakself.tableView reloadData];
                    
                    [SVProgressHUD dismiss];
                    
                }];
                break;
        }
        
    }
    

    
}





- (void)showAlertAction:(int)soundID {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Instrument  Setting" message:@"You can set this for Main Instrument" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Set for No.1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSString *)@"1"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Set for No.2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSString *)@"2"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Set for No.3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSString *)@"3"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        return;
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)otherButtonPushed:(NSString*)index {
    // 選択された番号をuse_itemsに更新
    self.use_items[index] = _selectedIndexPath;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.use_items forKey:@"use_items"];
    [defaults synchronize];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setSelectedItems {
    // 選択されている楽器を読み込む
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults dataForKey:@"use_items"] != nil) {
        self.use_items = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults dataForKey:@"use_items"]];
    }
}


@end
