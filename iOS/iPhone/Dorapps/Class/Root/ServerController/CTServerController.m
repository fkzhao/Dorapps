//
//  CTServerController.m
//  STAYREAL
//
//  Created by Ansel on 13-7-20.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTServerController.h"
#warning ---------ERROR----
//#import "CTSenderManager.h"
#import "NWRootViewController.h"

@interface CTServerController (){
    
}
@property (strong,nonatomic) NSMutableArray *serviceTokenArray;
@property (strong,nonatomic) NSMutableDictionary *serviceThreadArray;
@end
/** 服务控制器*/
@implementation CTServerController

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init{
    self = [super init];
    if (self) {
        blockDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.owner = nil;
        self.nextPage = nil;
        self.serviceTokenArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.serviceThreadArray = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

#pragma mark - --------------------System--------------------
#pragma mark - --------------------功能函数--------------------

#pragma mark - 服务结束
#warning ---------ERROR----
//-(void)serviceFinished:(CTServiceStatusModel *)model{
//    NSString *token = model.token;
//    if (model.isCanceled) {
//        [self removeBlocks:token];
//        return;
//    }
//    BOOL isSuccess = model.isSuccess;
//    //服务成功
//    if (isSuccess) {
//        void (^sBlocks)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject);
//        sBlocks = [blockDictionary objectForKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
//        sBlocks(model.token,0,self.nextPage);
//
//    } else { //服务失败
//
//        void (^fBlocks)(NSString *businessCode, NSString *errorInformation, id goToPageObject);
//        fBlocks = [blockDictionary objectForKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
//        fBlocks(model.errorCode,model.errorInfo,self.nextPage);
//    }
//
//    //清除这次服务的所有数据
//    [CTSenderManager clearAllWithToken:token];
//    //清楚BLOCKS
//    [self removeBlocks:token];
//    [self removeLoadingView];
//}
#pragma mark 启动服务监听线程
#warning ---------ERROR----
//- (void)listenServiceThread:(id)object
//{
//    @autoreleasepool {
//        CTSenderResultModel *queueResult = (CTSenderResultModel *)object;
//        NSString *queueToken = queueResult.resultToke;
//        CTServiceResultQueue *queue = [CTSenderManager getServiceReslutQueue:queueToken];//获取队列
//        CTServiceStatusModel *mainServiceModel = [queue getResultModel];//阻塞方法，每次take方法执行后
//        [self performSelectorOnMainThread:@selector(serviceFinished:) withObject:mainServiceModel waitUntilDone:YES];
//    }
//}

#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - UIAlertView代理

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NWRootViewController *nextVC = (NWRootViewController *)self.nextPage;
    [nextVC.navigationController popViewControllerAnimated:YES];
}

#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------
#pragma mark - 发送服务
#warning ---------ERROR----
//- (void)goTargetWithModel:(CTSenderResultModel *)model_queue
//               withMutaxArray:(NSArray *)mutaxTokenArray
//                cacheBean:(CTViewCacheBean *)cacheBean
//                    saveParam:(NSString *)saveParam
//        nextPageCahceBean:(CTViewCacheBean *)nextPageCahceBean
//                nextPageClass:(Class)nextClass
//                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
//                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
//{
//
//    NWRootViewController *target = nil;
//    target = self.owner;
//    if ([nextClass isSubclassOfClass:[NWRootViewController class]]) {
//        NWRootViewController *nextVC = [[nextClass alloc]init];
//        self.nextPage = nextVC;
//        self.nextPage.viewCacheBean = nextPageCahceBean;
//        CTCacheBeanResultQueue *queue = [[CTViewCacheManage shareInstance] getCacheQueueWithToken:model_queue.resultToke];
//        [queue put:nextPageCahceBean];
//        NWRootViewController *currentPage = (NWRootViewController *)self.owner;
//        [currentPage pushViewController:self.nextPage animated:YES];
//    }
//    
//    [self setBlocks:model_queue.resultToke successBlocks:sBlocks failedBlocks:fBlocks];
//    
//    //起线程监听服务状态
//    NSThread *newThread = [[NSThread alloc] initWithTarget:target.serviceController selector:@selector(listenServiceThread:) object:model_queue];
//    [newThread start];
//    [self.serviceThreadArray setObject:newThread forKey:model_queue.resultToke];
//}
//
//
///**
// 当前页面发送服服务
// 
// @param model_queue            发服务方法返回model
// @param sBlocks                服务成功回调模块
// @param fBlocks                服务失败回调模块
// */
//- (void)goToInsidePageWithModel:(CTSenderResultModel *)model_queue
//                 withMutaxArray:(NSArray *)mutaxTokenArray
//                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
//                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
//{
//    if (mutaxTokenArray) {
//        [self cancelAllService:mutaxTokenArray];
//    }
//    [self setBlocks:model_queue.resultToke successBlocks:sBlocks failedBlocks:fBlocks];
//    
//    //起线程监听服务状态
//    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(listenServiceThread:) object:model_queue];
//    [newThread start];
//    [self.serviceThreadArray setObject:newThread forKey:model_queue.resultToke];
//    self.owner.mutexServicetoken = model_queue.resultToke;
//
//}



#warning ---------ERROR----
//-(void)cancelAllService{
//    for (int i = 0; i < self.serviceTokenArray.count; i++) {
//        [CTSenderManager cancelTask:[NSString stringWithFormat:@"%@",[self.serviceTokenArray objectAtIndex:i]]];
//    }
//}

#warning ---------ERROR----
/**
 取消服务
 
 @param token  线程的token
 
 @return 不需要返回值
 */
//-(void)cancelService:(NSString *)token{
//    NSThread *thread = (NSThread *)[self.serviceThreadArray objectForKey:token];
//    [thread cancel];
//}
//
//-(void)cancelAllService:(NSArray *)mutexArray
//{
//    for (int i = 0; i < mutexArray.count; i ++)
//    {
//        NSString *token = [NSString stringWithFormat:@"%@",[mutexArray objectAtIndex:i]];
//        if (token.length == 0) {
//            return;
//        }
//        [CTSenderManager cancelTask:token];
//    }
//}
//
//-(eTaskStatus)checkServiceStatus:(NSString *)token
//{
//    return [CTSenderManager getTaskStatus:token];
//}

-(void)removeBlocks:(NSString *)token{
    [blockDictionary removeObjectForKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
    [blockDictionary removeObjectForKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
}

-(void)setBlocks:(NSString *)token
   successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
    failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [blockDictionary setObject:[sBlocks copy] forKey:[NSString stringWithFormat:@"%@-%@",token,SUCCESSBLOCKKEY]];
    [blockDictionary setObject:[fBlocks copy] forKey:[NSString stringWithFormat:@"%@-%@",token,FAILEDBLOCKKEY]];
}


-(void)removeLoadingView
{
    NWRootViewController *next = (NWRootViewController *)self.nextPage;
    if (next) {
        [next removeLoadingView:@"loading"];
    } else {
        [self.owner removeLoadingView:@"loading"];
    }
}
@end
