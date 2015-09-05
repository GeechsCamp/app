//
//  Instruments.h
//  bell-app
//
//  Created by 中原孟 on 2015/09/06.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Instruments : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSNumber * del_flg;

@end
