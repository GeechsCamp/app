//
//  DownloadView.h
//  bell-app
//
//  Created by M-025 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadView : UITableViewController

@property (nonatomic, copy)NSArray* datas;
@property (nonatomic, copy)NSMutableDictionary* use_items;
@property (nonatomic, copy)NSMutableArray* dl_items;

- (IBAction)cancel:(id)sender;


@end
