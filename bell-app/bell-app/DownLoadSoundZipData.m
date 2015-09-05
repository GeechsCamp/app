//
//  DownLoadSoundZipData.m
//  bell-app
//
//  Created by 中原孟 on 2015/09/05.
//  Copyright (c) 2015年 VCJPCM012. All rights reserved.
//

#import "DownLoadSoundZipData.h"
#import <AFNetworkActivityLogger.h>

@implementation DownLoadSoundZipData


+(void)downloadZipData:(NSString*)soundId {

    // http://geechscamp.xyz/zip_files/1.zip
    
    NSString* baseurlstr = @"http://geechscamp.xyz/zip_files/";
    NSString* urlstr = [NSString stringWithFormat:@"%@%@.zip",baseurlstr,soundId];

    NSURL* url = [NSURL URLWithString:urlstr];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               //UIImage* image = [UIImage imageWithData:data];
               
               NSLog(@"成功");
               
               NSFileManager *fileManager = [NSFileManager defaultManager];
               
               NSLog(@"成功途中だよ");
               
               
               //tmpパス取得
               NSString *tmpDirPath = NSTemporaryDirectory();
               NSString* fileTmpSavePath = [NSString stringWithFormat:@"%@tmp.zip",tmpDirPath];
               
               //zipdataをデータ型に変換
               NSData* zipConvertedData = data/*[NSKeyedArchiver archivedDataWithRootObject:responseObject]*/;
               
               //Library/Cachesディレクトリ作成（展開したデータを永続的に保存する）
               NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
               NSString *cachesDirPath = [paths objectAtIndex:0];
               
               //新たなResourcesフォルダを作成
               NSString* Resourcespath = [NSString stringWithFormat:@"Resources"];
               
               NSString *fileCachesSavePath = [cachesDirPath stringByAppendingPathComponent:Resourcespath];
               
               BOOL directorycreated = [fileManager createDirectoryAtPath:fileCachesSavePath withIntermediateDirectories:YES attributes:nil error:&error];
               
               if(directorycreated) //ディレクトリ作成に成功したらorディレクトリがあったら
               {
                   //zipデータをtmp以下に保存
                   BOOL successSaveZip = [fileManager createFileAtPath:fileTmpSavePath contents:zipConvertedData attributes:nil];
                   
                   if(successSaveZip)
                   {
                       //zipの解凍
                       //BOOL isSuccess = [SSZipArchive unzipFileAtPath:fileTmpSavePath toDestination:fileCachesSavePath overwrite:YES password:nil error:nil delegate:self];
                       BOOL isSuccess = [SSZipArchive unzipFileAtPath:fileTmpSavePath toDestination:fileCachesSavePath];
                       
                       if(isSuccess) {
                           
                           //tmp内削除
                           fileManager = [[NSFileManager alloc]init];
                           [fileManager removeItemAtPath:tmpDirPath error:NULL];
                           
                           
                       }
                   }
               }
               
               // UIImageVIewを更新する
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   
                   
               });
           }];
    
    [task resume];
    
    
    
    
}







@end
