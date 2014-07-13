//
//  NWCoreData.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCoreData.h"
#import "NWCoreDataAdapter.h"

@interface NWCoreData ()

/*!
 *  CoreData管理上下文
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/*!
 *  管理对象model
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/*!
 *  解析器
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation NWCoreData
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*!
 *  获取单例
 *
 *  @return NWCoreData 单例
 */
+(instancetype)shareObject
{
    static NWCoreData *shareObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
    });
    return shareObj;
}

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------

#pragma mark - --------------------全局--------------------
/*!
 *  获取某个类型的所有数据
 *
 *  @param class 该类型的Class
 *
 *  @return 该Class实例对象数组
 */
- (void)saveContext
{
    @synchronized(self) {
        NSError *error = nil;
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        if (managedObjectContext != nil) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
}

#pragma mark - --------------------插入数据--------------------
/*!
 *  插入对象
 *
 *  @param item 需要插入的Common对象
 */
-(void)insertDataWith:(NSObject *)item
{
    @synchronized(self) {
        NSString *className = NSStringFromClass([item class]);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *managedObject = [NSEntityDescription
                                           insertNewObjectForEntityForName:manageObjectName
                                           inManagedObjectContext:context];
        [NWCoreDataAdapter adapterCommonObject:item toManagerObject:&managedObject];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

#pragma mark - --------------------获取数据--------------------
/*!
 *  获取某个类型的所有数据
 *
 *  @param class 该类型的Class
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchAllDataWith:(Class)class
{
    @synchronized(self) {
        return [self fetchDataWith:class withConditionString:@""];
    }
}

/*!
 *  根据条件获取Common对象
 *
 *  @param class     Common对象Class
 *  @param condition 条件字典 字典中的key value 是AND拼接
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchDataWith:(Class)class withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
                NSString *predicateString = @"";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 0) {
                predicateString = [NSString stringWithFormat:@"(%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        if(predicateString.length != 0){
            predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        }
        return [self fetchDataWith:class withConditionString:predicateString];
    }
}

/*!
 *  根据条件获取Common对象
 *
 *  @param class     Common对象Class
 *  @param condition 条件字符串
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchDataWith:(Class)class withConditionString:(NSString *)condition
{
    @synchronized(self) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]initWithCapacity:0];
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:manageObjectName inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        if (condition.length != 0) {
            NSString *predicateString = [NSString stringWithFormat:@"(%@)",condition];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
            [fetchRequest setPredicate:predicate];
        }
        NSError *error = nil;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects) {
            id item = [NWCoreDataAdapter adapterManagedObject:info toCommonObjectClass:class];
            [dataArray addObject:item];
        }
        return dataArray;
    }
}

#pragma mark - --------------------删除数据--------------------
/*!
 *  根据条件删除数据
 *
 *  @param class     要删除对象的Class
 *  @param condition 条件字典 字典中的key value 是AND拼接
 */
-(void)deleteDataWith:(Class)class withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
        NSString *predicateString = @"";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 0) {
                predicateString = [NSString stringWithFormat:@"(%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        if(predicateString.length != 0){
            predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        }
        [self deleteDataWith:class withConditionString:predicateString];
    }
}
/*!
 *  根据条件删除数据
 *
 *  @param class     要删除对象的Class
 *  @param condition 条件字符串
 */
-(void)deleteDataWith:(Class)class withConditionString:(NSString *)condition
{
    @synchronized(self) {
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:manageObjectName inManagedObjectContext:context];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setIncludesPropertyValues:NO];
        [fetchRequest setEntity:entity];
        if (condition.length != 0) {
            NSString *predicateString = [NSString stringWithFormat:@"(%@)",condition];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
            [fetchRequest setPredicate:predicate];
        }
        NSError *error = nil;
        NSArray *datas = [context executeFetchRequest:fetchRequest error:&error];
        if (!error && datas && [datas count]){
            for (NSManagedObject *obj in datas) {
                [context deleteObject:obj];
            }
            if (![context save:&error]) {
                NSLog(@"error:%@",error);
            }
        }
    }
}

/*!
 *  删除某个Common Class所有数据
 *
 *  @param class Common ClassName
 */
-(void)deleteAllDataWith:(Class)class
{
    @synchronized(self) {
        [self deleteDataWith:class withConditionString:@""];
    }
}

/*!
 *  清空CoreData所有对象
 */
-(void)deleteAllData
{
    @synchronized(self) {
        
    }
}

#pragma mark - --------------------更新数据--------------------
/*!
 *  更新对象
 *
 *  @param item      需要更新的对象（新对象）
 *  @param condition 更新条件字典 字典中的key value 是AND拼接
 */
-(void)updateDataWith:(NSObject *)item withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
        NSString *predicateString = @"";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 0) {
                predicateString = [NSString stringWithFormat:@"(%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        if(predicateString.length != 0){
            predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        }
        [self updateDataWith:item withConditionString:predicateString];
    }
}

/*!
 *  更新对象
 *
 *  @param item      需要更新的对象（新对象
 *  @param condition 条件字符串
 */
-(void)updateDataWith:(NSObject *)item withConditionString:(NSString *)condition
{
    @synchronized(self) {
        NSString *className = NSStringFromClass([item class]);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:manageObjectName inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        if (condition.length != 0) {
            NSString *predicateString = [NSString stringWithFormat:@"(%@)",condition];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
            [fetchRequest setPredicate:predicate];
        }
        NSError *error = nil;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (int i = 0;i < [fetchedObjects count];i++) {
            NSManagedObject *managedObject = [fetchedObjects objectAtIndex:i];
            [NWCoreDataAdapter adapterCommonObject:item toManagerObject:&managedObject];
        }
        if ([context save:&error]) {
            NSLog(@"Update Success.");
        }
    }
}

#pragma mark - --------------------获取行数--------------------
/*!
 *  获取行数
 *
 *  @param class Common对象Class
 *
 *  @return 行数
 */
-(NSInteger)fetchNumberOfRow:(Class)class
{
    @synchronized(self) {
        return [self fetchNumberOfRow:class withConditionString:@""];
    }
}

/*!
 *  获取行数
 *
 *  @param class     Common对象Class
 *  @param condition 条件Dic
 *
 *  @return 函数
 */
-(NSInteger)fetchNumberOfRow:(Class)class withCondition:(NSDictionary *)condition
{
    @synchronized(self) {
        NSString *predicateString = @"";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 0) {
                predicateString = [NSString stringWithFormat:@"(%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        if(predicateString.length != 0){
            predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        }
        return [self fetchNumberOfRow:class withConditionString:predicateString];
    }
}

/*!
 *  获取行数
 *
 *  @param class     Common对象Class
 *  @param condition 条件字符串
 *
 *  @return 函数
 */
-(NSInteger)fetchNumberOfRow:(Class)class withConditionString:(NSString *)condition
{
    @synchronized(self) {
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:manageObjectName inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        if (condition.length != 0) {
            NSString *predicateString = [NSString stringWithFormat:@"(%@)",condition];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
            [fetchRequest setPredicate:predicate];
        }
        NSError *error = nil;
        NSInteger rowCount = [context countForFetchRequest:fetchRequest error:&error];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
            rowCount = 0;
        }
        return rowCount;
    }
}
@end
