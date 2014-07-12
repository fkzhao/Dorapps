//
//  NWServerController.m
//  Dorapps
//
//  Created by Ansel on 13-7-20.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "NWServerController.h"
#import "NWRootViewController.h"
#import "NWServiceUtil.h"
#import "NWViewCacheBeanManager.h"

@interface NWServerController (){
    
}
@property (strong,nonatomic) NSMutableArray *serviceTokenArray;

@end
/** 服务控制器*/
@implementation NWServerController

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init{
    self = [super init];
    if (self) {
        blockDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.owner = nil;
        self.serviceTokenArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.serviceThreadArray = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

#pragma mark - --------------------System--------------------
#pragma mark - --------------------功能函数--------------------

#pragma mark - 服务结束
-(void)serviceFinished:(NWServiceStatusModel *)model{
    NSString *token = model.token;
    if (model.isCanceled) {
        [self removeBlocks:token];
        return;
    }
    BOOL isSuccess = model.isSuccess;
    //服务成功
    if (isSuccess) {
        void (^sBlocks)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject);
        sBlocks = [blockDictionary objectForKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
        if (sBlocks) {
            sBlocks(model.token,0,self.owner);
        }
        
    } else { //服务失败
        void (^fBlocks)(NSString *businessCode, NSString *errorInformation, id goToPageObject);
        fBlocks = [blockDictionary objectForKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
        if (fBlocks) {
            fBlocks(model.errorCode,model.errorInfo,self.owner);
        }
    }
    //清除BLOCKS
    [self removeBlocks:token];
    [self removeLoadingView];
}
#pragma mark 启动服务监听线程
- (void)listenServiceThread:(id)object
{
    @autoreleasepool {
        NWSenderResultModel *queueResult = (NWSenderResultModel *)object;
        NSString *queueToken = queueResult.resultToke;
        NWServiceStatusModel *mainServiceModel = [NWServiceUtil fetchServiceStatusModel:queueToken];//阻塞方法，每次take方法执行后
        [self performSelectorOnMainThread:@selector(serviceFinished:) withObject:mainServiceModel waitUntilDone:YES];
    }
}

#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - UIAlertView代理

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NWRootViewController *nextVC = self.owner;
    [nextVC.navigationController popViewControllerAnimated:YES];
}

#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------
#pragma mark - 发送服务
- (void)goTargetWithModel:(NWSenderResultModel *)model_queue
               withMutaxArray:(NSArray *)mutaxTokenArray
                cacheBean:(NWViewCacheBean *)cacheBean
                    saveParam:(NSString *)saveParam
        nextPageCahceBean:(NWViewCacheBean *)nextPageCahceBean
                nextPageClass:(Class)nextClass
                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    NWRootViewController *target = nil;
    if ([nextClass isSubclassOfClass:[NWRootViewController class]]) {
        NWRootViewController *nextVC = [[nextClass alloc]init];
        target = nextVC;
        nextVC.viewCacheBean = nextPageCahceBean;
        [NWViewCacheBeanManager setViewCacheBean:nextPageCahceBean withToken:model_queue.resultToke];
        NWRootViewController *currentPage = (NWRootViewController *)self.owner;
        [currentPage pushViewController:nextVC animated:YES];
    }
    
    [target.serviceController setCallBackBlocks:model_queue.resultToke successBlocks:sBlocks failedBlocks:fBlocks];
    
    //起线程监听服务状态
    NSThread *newThread = [[NSThread alloc] initWithTarget:target.serviceController selector:@selector(listenServiceThread:) object:model_queue];
    [newThread start];
    [self.serviceThreadArray setObject:newThread forKey:model_queue.resultToke];
}


/**
 当前页面发送服服务
 
 @param model_queue            发服务方法返回model
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                 withMutaxArray:(NSArray *)mutaxTokenArray
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    if (mutaxTokenArray) {
        [self cancelAllService:mutaxTokenArray];
    }
    [self setCallBackBlocks:model_queue.resultToke successBlocks:sBlocks failedBlocks:fBlocks];
    
    //起线程监听服务状态
    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(listenServiceThread:) object:model_queue];
    [newThread start];
    [self.serviceThreadArray setObject:newThread forKey:model_queue.resultToke];
    self.owner.mutexServicetoken = model_queue.resultToke;

}


-(void)cancelAllService{
    for (int i = 0; i < self.serviceTokenArray.count; i++) {
        [NWServiceUtil cancelServiceWith:[NSString stringWithFormat:@"%@",[self.serviceTokenArray objectAtIndex:i]]];
    }
}

/**
 取消服务
 
 @param token  线程的token
 
 @return 不需要返回值
 */
-(void)cancelService:(NSString *)token{
    NSThread *thread = (NSThread *)[self.serviceThreadArray objectForKey:token];
    [thread cancel];
}

-(void)cancelAllService:(NSArray *)mutexArray
{
    for (int i = 0; i < mutexArray.count; i ++)
    {
        NSString *token = [NSString stringWithFormat:@"%@",[mutexArray objectAtIndex:i]];
        if (token.length == 0) {
            return;
        }
        [NWServiceUtil cancelServiceWith:token];
    }
}

-(void)removeBlocks:(NSString *)token{
    [blockDictionary removeObjectForKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
    [blockDictionary removeObjectForKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
}

-(void)setCallBackBlocks:(NSString *)token
   successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
    failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [blockDictionary setObject:[sBlocks copy] forKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
    [blockDictionary setObject:[fBlocks copy] forKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
}


-(void)removeLoadingView
{
    NWRootViewController *next = (NWRootViewController *)self.owner;
    if (next) {
        [next removeLoadingView:@"loading"];
    } else {
        [self.owner removeLoadingView:@"loading"];
    }
}
@end
