//
//  NWCoreData.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NWLocationItem;
@class NWLocationObjectItem;

/*!
 *  CoreData核心类
 */
@interface NWCoreData : NSObject
#pragma mark - --------------------全局--------------------
/*!
 *  持久化CoreData
 */
- (void)saveContext;

/*!
 *  获取单例
 *
 *  @return NWCoreData 单例
 */
+(instancetype)shareObject;

#pragma mark - --------------------插入数据--------------------

/*!
 *  插入对象
 *
 *  @param item 需要插入的Common对象
 */
-(void)insertDataWith:(NSObject *)item;

#pragma mark - --------------------获取数据--------------------

/*!
 *  获取某个类型的所有数据
 *
 *  @param class 该类型的Class
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchAllDataWith:(Class)class;

/*!
 *  根据条件获取Common对象
 *
 *  @param class     Common对象Class
 *  @param condition 条件字典 字典中的key value 是AND拼接
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchDataWith:(Class)class withCondition:(NSDictionary *)condition;

/*!
 *  根据条件获取Common对象
 *
 *  @param class     Common对象Class
 *  @param condition 条件字符串
 *
 *  @return 该Class实例对象数组
 */
-(NSArray *)fetchDataWith:(Class)class withConditionString:(NSString *)condition;

#pragma mark - --------------------删除数据--------------------
/*!
 *  根据条件删除数据
 *
 *  @param class     要删除对象的Class
 *  @param condition 条件字典 字典中的key value 是AND拼接
 */
-(void)deleteDataWith:(Class)class withCondition:(NSDictionary *)condition;

/*!
 *  根据条件删除数据
 *
 *  @param class     要删除对象的Class
 *  @param condition 条件字符串
 */
-(void)deleteDataWith:(Class)class withConditionString:(NSString *)condition;

/*!
 *  删除某个Common Class所有数据
 *
 *  @param class Common ClassName
 */
-(void)deleteAllDataWith:(Class)class;

/*!
 *  清空CoreData所有对象
 */
-(void)deleteAllData;

#pragma mark - --------------------更新数据--------------------

/*!
 *  更新对象
 *
 *  @param item      需要更新的对象（新对象）
 *  @param condition 更新条件字典 字典中的key value 是AND拼接
 */
-(void)updateDataWith:(NSObject *)item withCondition:(NSDictionary *)condition;

/*!
 *  更新对象
 *
 *  @param item      需要更新的对象（新对象
 *  @param condition 条件字符串
 */
-(void)updateDataWith:(NSObject *)item withConditionString:(NSString *)condition;

#pragma mark - --------------------获取行数--------------------
/*!
 *  获取行数
 *
 *  @param class Common对象Class
 *
 *  @return 行数
 */
-(NSInteger)fetchNumberOfRow:(Class)class;

/*!
 *  获取行数
 *
 *  @param class     Common对象Class
 *  @param condition 条件Dic
 *
 *  @return 函数
 */
-(NSInteger)fetchNumberOfRow:(Class)class withCondition:(NSDictionary *)condition;

/*!
 *  获取行数
 *
 *  @param class     Common对象Class
 *  @param condition 条件字符串
 *
 *  @return 函数
 */
-(NSInteger)fetchNumberOfRow:(Class)class withConditionString:(NSString *)condition;
@end
