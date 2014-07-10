//
//  NWTableViewDefine.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#ifndef APPVV_NWTableViewDefine_h
#define APPVV_NWTableViewDefine_h
typedef enum {
    ePullStateTypeNormal = 1,
    ePullStateTypeDown,         //状态标识：释放可以刷新
    ePullStateTypeUp,           //状态标识：释放加载更多
    ePullStateTypeRefresh,      //状态标识：正在刷新
    ePullStateTypeLoadMore,     //状态标识：正在加载
    ePullStateTypeEnd,          //状态标识：已加载全部数据
} ePullStateType;

typedef enum {
    ePullActionTypeDoNothing,   //动作：不执行
    ePullActionTypeRefresh,     //动作：下拉刷新
    ePullActionTypeLoadMore,    //动作：加载更多
} ePullActionType;



#endif
