//
//  CTSenderResultModel.h
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 发送一个sender返回的ResultModel*/
@interface CTSenderResultModel : NSObject

/** 当前sender的token*/
@property (nonatomic,copy) NSString *resultToke;

@end
