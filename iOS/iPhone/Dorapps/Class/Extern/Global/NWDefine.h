//
//  NWDefine.h
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#ifndef APPVV_NWDefine_h
#define APPVV_NWDefine_h

#define NWColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define NWColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define isIos7 ([[UIDevice currentDevice].systemVersion floatValue]>= 7.0 \
? YES : NO)



#endif
