//
//  CTConfig.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-3.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#ifndef StayReal_Sender_CTConfig_h
#define StayReal_Sender_CTConfig_h
//#define IN_PRODUCT_EVN

#ifdef IN_PRODUCT_EVN
    /*
     线上环境
     **/
    static NSString *httpURL = @"http://api.neoworkstudio.com/sr/";
    #define CRITTERCISM_APPID @"530b726f2e2e1f733e000002"
#else
    /*
     测试环境
     **/
    static  NSString *httpURL = @"http://beta.neoworkstudio.com/api.neoworkstudio.com/sr/";
    #define CRITTERCISM_APPID @"530b7674f7b7da5aa8000007"
#endif

/**
 *  接口名称定义
 */
#define LIST_API            @"stayreal_detail.php"
#define LOAD_LIST_API       @"stayreal_new_list.php"
#define DETAIL_API          @"stayreal_detail.php"
#define CATEGORY_API        @"stayreal_category_list.php"
#define SEARCH_API          @"stayreal_list.php"
#define REGISTER_DEVICE_API @"stayreal_regist_device.php"




/*
 字典类型定义
**/
#define ERRINFO_MODEL @"errorModel"
#define DES_KEYWORLD  @"STAYREAL"
#endif
