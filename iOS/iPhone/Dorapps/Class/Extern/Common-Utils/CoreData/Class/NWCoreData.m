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

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation NWCoreData
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


+(instancetype)shareObject
{
    static NWCoreData *shareObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
    });
    return shareObj;
}


-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

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

-(NSArray *)fetchAllDataWith:(Class)class
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
        NSError *error = nil;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects) {
            id item = [NWCoreDataAdapter adapterManagedObject:info toCommonObjectClass:class];
            [dataArray addObject:item];
        }
        return dataArray;
    }
}


-(id)fetchDataWith:(Class)class withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
        id item =nil;
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:manageObjectName inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSString *predicateString = @"(";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 1) {
                predicateString = [NSString stringWithFormat:@"%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [fetchRequest setPredicate:predicate];
        NSError *error = nil;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *info in fetchedObjects) {
            item = [NWCoreDataAdapter adapterManagedObject:info toCommonObjectClass:class];
        }
        return item;
    }
}

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

-(void)deleteDataWith:(Class)class withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:manageObjectName inManagedObjectContext:context];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setIncludesPropertyValues:NO];
        [fetchRequest setEntity:entity];
        NSString *predicateString = @"(";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 1) {
                predicateString = [NSString stringWithFormat:@"%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [fetchRequest setPredicate:predicate];
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
-(void)deleteAllDataWith:(Class)class
{
    @synchronized(self) {
        NSString *className = NSStringFromClass(class);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:manageObjectName inManagedObjectContext:context];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setIncludesPropertyValues:NO];
        [fetchRequest setEntity:entity];
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
-(void)deleteAllData
{
    @synchronized(self) {
        
    }
}

-(void)updateDataWith:(NSObject *)item withCondition:(NSDictionary *)condition;
{
    @synchronized(self) {
        NSString *className = NSStringFromClass([item class]);
        NSString *manageObjectName = [className substringFromIndex:2];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:manageObjectName inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSString *predicateString = @"(";
        for (NSString *key in [condition allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[condition objectForKey:key]];
            if (predicateString.length == 1) {
                predicateString = [NSString stringWithFormat:@"%@%@ = '%@'",predicateString,key,value];
            } else {
                predicateString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",predicateString,key,value];
            }
        }
        predicateString = [NSString stringWithFormat:@"%@)",predicateString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [fetchRequest setPredicate:predicate];
        NSError *error = nil;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        for (int i = 0;i < [fetchedObjects count];i++) {
            NSManagedObject *managedObject = [fetchedObjects objectAtIndex:i];
            [NWCoreDataAdapter adapterCommonObject:item toManagerObject:&managedObject];
        }
        
        if ([context save:&error]) {
            NSLog(@"更新成功");
        }
    }
}
@end
