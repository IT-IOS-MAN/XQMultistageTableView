//
//  XQMultistageNode.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    XQNodeContentTypeSuper, // 父节点
    XQNodeContentTypeSub, // 子节点
}XQNodeContentType;

typedef void(^SelectedStateChangeBlock)(BOOL);

@interface XQMultistageNode : NSObject

#pragma 共同拥有
/// 节点名称
@property(nonatomic, copy) NSString *title;

/// 父节点的id，如果为-1表示该节点为根节点
@property (nonatomic , retain) NSString *parentCode;

/// 本节点的id
@property (nonatomic , retain) NSString *nodeCode;

/// 该节点的深度
@property (nonatomic , assign) NSInteger depth;

/// 内容类型
@property (nonatomic , assign) XQNodeContentType contentType;

/// 是否可以选
@property (nonatomic , assign) BOOL selectState;

/// 当前是否需选择
@property (nonatomic , assign) BOOL currentSelected;

@property (nonatomic , strong) SelectedStateChangeBlock selectedStateChange;

#pragma Super
/// 子节点列表
@property (nonatomic, strong) NSMutableArray *subItems;

/// 该节点是否处于展开状态
@property (nonatomic , assign) BOOL isExpand;



@end

