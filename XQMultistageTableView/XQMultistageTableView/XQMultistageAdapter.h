//
//  XQMultistageAdapter.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQMultistageCell.h"

@class XQMultistageAdapter, XQMultistageNode, XQMultistageTableView;

@protocol XQMultistageAdapterDelegate <NSObject>

@optional

// 是否关闭子节点 默认是 NO
- (BOOL)xq_multistageAdapterShouldCloseSubNode:(XQMultistageAdapter *) adapter;

// 父节点可不可以点击 默认是 NO
- (BOOL)xq_multistageAdapterUnClickSuperNode:(XQMultistageAdapter *) adapter;

// cell 点击事件
- (void)xq_multistageAdapter:(XQMultistageAdapter *) adapter didSelectRowAtNode:(XQMultistageNode *) node;

// 选择展示功能 -> 状态改变
- (void)xq_multistageAdapter:(XQMultistageAdapter *) adapter didSelectStateChangeAtNode:(XQMultistageNode *) node selectState:(BOOL) state;

// 行高
- (CGFloat)xq_multistageAdapter:(XQMultistageAdapter *) adapter heightForRowAtNode:(XQMultistageNode *) node;

// 自定义 cell
- (XQMultistageCell *)xq_multistageAdapter:(XQMultistageAdapter *) adapter tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XQMultistageAdapter : NSObject<UITableViewDataSource, UITableViewDelegate>

// 代理
@property(nonatomic, weak) id<XQMultistageAdapterDelegate> delegate;

// 多级展示的数据
@property(nonatomic, weak) NSMutableArray<XQMultistageNode *> *multistageData;

// 单选
@property(nonatomic, assign) BOOL radio;

// 多选的状态下的选择节点
@property(nonatomic, strong) NSMutableArray<XQMultistageNode *> *selectNode;

@end
