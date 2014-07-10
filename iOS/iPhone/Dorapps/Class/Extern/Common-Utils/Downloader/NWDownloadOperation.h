//
//  NWDownloadOperation.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWDownloadProtocol.h"

@interface NWDownloadOperation : NSOperation
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *downloadURL;
@property (nonatomic,assign) id<NWDownloaderDelegate> downloadDelegate;

-(id)initWith:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate withToken:(NSString *)token;
@end
