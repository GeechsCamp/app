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




@interface DownloadView ()

@property (nonatomic, copy)NSNumber *selected_id;

@end

@implementation DownloadView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateAllSoundsLocalData];
    
    [self setDummyData];
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
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadCell" forIndexPath:indexPath];
    
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadCell" forIndexPath:indexPath];
    
//    NSString *key = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
//    cell.textLabel.text = self.datas[key][@"name"];
    
    //NSDictionary *data = [self.datas objectAtIndex:indexPath.row];
    NSArray* array = [Instruments MR_findAll];
    Instruments* instrument = [array objectAtIndex:indexPath.row];
    NSLog(@"名前=%@",instrument.name);
    [cell setDataOfRow:instrument];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.datas objectAtIndex:indexPath.row];
    self.selected_id = data[@"id"];
    
//    NSInteger item_id = (long)data[@"id"];
    
    // 選択された楽器がダウンロードされてるかを判定
//    BOOL is_dl = NO;
//    for (id dl_item in self.dl_items) {
//        if (item_id == dl_item) {
//            is_dl = YES;
//            break;
//        }
//    }
//    if (!is_dl) return;
    
    // ダウンロードされてた場合、設定するアラートを出す
    [self showAlertAction];
}


- (void)showAlertAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"楽器設定" message:@"メイン画面で使える楽器をセットします。" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"1のボタンに設定する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSInteger *)1];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"2のボタンに設定する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSInteger *)2];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"3のボタンに設定する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:(NSInteger *)2];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        return;
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)otherButtonPushed:(NSInteger*)index {
    // 選択された番号をuse_itemsに更新
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be .
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setDummyData {
    
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
    self.datas = datas;
    
    // use_items - 使用中の楽器の情報
    // @楽器順の番号:@楽器id
    NSMutableDictionary *use_items = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @1,@0,
                            @2,@1,
                            @3,@0,
    nil];
    self.use_items = use_items;
    
    // dl_items - ダウンロードされた楽器情報+zipデータ
    // @id
    NSMutableArray *dl_items = [NSMutableArray arrayWithObjects:@0,nil];
    self.dl_items = dl_items;
}

@end
