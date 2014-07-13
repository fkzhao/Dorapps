//
//  NWDownloadCenter.m
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadCenter.h"
#import "NWDownloadInstance.h"
#import "NWCoreDataUtil.h"

@interface NWDownloadCenter ()

/*!
 *  已下载的数组
 */
@property (nonatomic,strong) NSMutableArray *downloadedArray;
/*!
 *  正在下载字典
 */
@property (nonatomic,strong) NSMutableDictionary *downloadingDictionary;
/*!
 *  已经取消下载的字典
 */
@property (nonatomic,strong) NSMutableDictionary *canceledDictionary;

@end

@implementation NWDownloadCenter

-(id)init
{
    self = [super init];
    if (self) {
        self.downloadedArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.downloadingDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.canceledDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

/*!
 *  获取单例
 *
 *  @return NWDownloadCenter 单例对象
 */
+(instancetype)defaultCenter
{
    static NWDownloadCenter *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc]init];
    });
    return obj;
}

/*!
 *  同步数据到CoreData
 *
 *  @return BOOL 是否同步成功
 */
-(BOOL)synchronize
{
    return YES;
}

/*!
 *  添加下载任务
 *
 *  @param model App的模型
 */
-(void)addDownloadTask:(NWListAppModel *)model
{
    @synchronized(_downloadingDictionary){
        NWDownloadInstance *downloadInstance = [[NWDownloadInstance alloc]init];
        [downloadInstance launchDonwloadTask:model];
        [_downloadingDictionary setObject:downloadInstance forKey:downloadInstance.token];
        [NWCoreDataUtil insertDownloadAppItem:downloadInstance.downloadApp];
    }
}
/*!
 *  结束任务
 *
 *  @param token token
 */
-(void)finishDownloadTask:(NSString *)token
{
    @synchronized(_downloadingDictionary){
        if ([[_downloadingDictionary allKeys] containsObject:token]) {
            NWDownloadInstance *downloadInstance = (NWDownloadInstance *)[_downloadingDictionary objectForKey:token];
            [NWCoreDataUtil updateDownloadItem:downloadInstance.downloadApp withKey:@"url" withValue:downloadInstance.downloadApp.url];
        }
    }
}

/*!
 *  获取所有下载任务
 */
-(void)fetchAllDownloadTask
{
    
}

/*!
 *  获取所有已下载任务
 */
-(void)fetchAllDownloadedTask
{
    
}

/*!
 *  获取所有正在下载任务
 */
-(void)fetchAllDownloadingTask
{
    
}

/*!
 *  移除下载任务
 *
 *  @param model App模型
 */
-(void)removeDownloadTask:(NWListAppModel *)model
{
    
}

/*!
 *  暂停下载任务
 *
 *  @param model App模型
 */
-(void)cancelDownloadTask:(NWListAppModel *)model
{
    
}
@end
