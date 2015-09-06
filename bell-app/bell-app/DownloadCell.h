//
//  DownloadCell.h
//  bell-app
//
//  Created by M-025 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instruments.h"

@interface DownloadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@property (weak, nonatomic) IBOutlet UIButton *download;
- (IBAction)download:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *useitembtn;
- (IBAction)useitem:(id)sender;

//- (void)setDataOfRow:(NSDictionary *)dataOfRow;
-(void)setDataOfRow:(Instruments*)instrument;

@end
