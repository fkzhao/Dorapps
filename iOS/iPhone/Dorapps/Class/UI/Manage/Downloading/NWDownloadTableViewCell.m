//
//  NWDownloadTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadTableViewCell.h"
#import "NWDownloader.h"
#import "NWDownloadModel.h"

@interface NWCellDownloadModel : NSObject

@property (nonatomic,strong) NSString *token;
@property (nonatomic,assign) CGFloat progressValue;
@end

@implementation NWCellDownloadModel



@end



@interface NWCellDownloadModelManager : NSObject
@property (nonatomic,strong) NSMutableDictionary *downloadDictionary;
+(NWCellDownloadModelManager *)shareObjc;
-(void)setDownloadModel:(NSString *)key withModel:(NWCellDownloadModel *)model;
-(NWCellDownloadModel *)getDownloadModel:(NSString *)key;
-(void)removeDonwloadModel:(NSString *)key;
-(BOOL)hasDownloadeModel:(NSString *)key;
@end

@implementation NWCellDownloadModelManager

-(id)init
{
    self = [super init];
    if (self) {
        self.downloadDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}



+(NWCellDownloadModelManager *)shareObjc
{
    static NWCellDownloadModelManager *shareObj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareObj = [[NWCellDownloadModelManager alloc] init];
    });
    return shareObj;
}

-(void)setDownloadModel:(NSString *)key withModel:(NWCellDownloadModel *)model
{
    @synchronized(self) {
        if (![[self.downloadDictionary allKeys] containsObject:key]) {
            [self.downloadDictionary setObject:model forKey:key];
        }
    }
}
-(NWCellDownloadModel *)getDownloadModel:(NSString *)key
{
    @synchronized(self) {
        if ([[self.downloadDictionary allKeys] containsObject:key]) {
            NWCellDownloadModel *model = (NWCellDownloadModel *)[self.downloadDictionary objectForKey:key];
            return model;
        }
        return nil;
    }
}
-(void)removeDonwloadModel:(NSString *)key
{
    @synchronized(self) {
         if ([[self.downloadDictionary allKeys] containsObject:key]) {
             [self.downloadDictionary removeObjectForKey:key];
         }
    }
}

-(BOOL)hasDownloadeModel:(NSString *)key
{
    @synchronized(self) {
        if ([[self.downloadDictionary allKeys] containsObject:key]) {
            return YES;
        } else {
            return NO;
        }
    }
}
@end


@interface NWDownloadTableViewCell()<NWDownloaderDelegate>
{
    
}
@property (nonatomic,strong) NWCellDownloadModel *currentModel;
@end

@implementation NWDownloadTableViewCell


-(id)init
{
    self = [super init];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (IBAction)doAction:(id)sender {
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self initBaseView];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseView];
    }
    return self;
}


-(void)initBaseData
{
    self.currentModel = nil;
}

-(void)initBaseView
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)downloadTask:(NSString *)url withIndexPath:(NSIndexPath *)indexPath;
{
    
    NSString *key = [NSString stringWithFormat:@"Section%liRow%li",(long)indexPath.section,(long)indexPath.row];
    if ([[NWCellDownloadModelManager shareObjc]hasDownloadeModel:key]) {
        self.currentModel = [[NWCellDownloadModelManager shareObjc] getDownloadModel:key];
    } else {
        NSString *token = [NWDownloader addDownloader:url withDelegate:self];
        NWCellDownloadModel *model = [[NWCellDownloadModel alloc]init];
        model.progressValue = 0.0;
        model.token = token;
        [[NWCellDownloadModelManager shareObjc] setDownloadModel:key withModel:model];
        self.currentModel = model;
    }
    [self updateViewWith:self.currentModel];
}
-(void)downloadProgress:(CGFloat)progressValue withToken:(NSString *)token
{
    if ([token isEqualToString:self.currentModel.token]) {
        self.currentModel.progressValue = progressValue;
        [self updateViewWith:self.currentModel];
    }
}

-(void)updateViewWith:(NWCellDownloadModel *)model
{
    self.progressView.progress = model.progressValue;
    if (model.progressValue == 1.0) {
        self.statusLabel.text = @"完成";
    } else if (model.progressValue == 0.0) {
        self.statusLabel.text = @"准备";
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@"%.2lf%%",model.progressValue*100];
    }
    
}

-(void)downloadFinished:(NSString *)token
{
    NSLog(@"did Finish.");
}

-(void)dealloc
{
    
}
@end
