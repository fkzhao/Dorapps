//
//  CTSenderCallBack.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTTaskOperation;

typedef BOOL (^SenderSuccessMethod)(CTTaskOperation *task,NSDictionary *dic);
typedef BOOL (^SenderFailMethod)(CTTaskOperation *task,NSDictionary *dic);




@interface CTSenderCallBack : NSObject{
    SenderSuccessMethod senderSuccess;
    SenderFailMethod senderFail;
   
}
@property (copy) SenderSuccessMethod senderSuccess;
@property (copy) SenderFailMethod senderFail;

@end

