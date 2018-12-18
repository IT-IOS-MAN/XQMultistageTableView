//
//  XQMultistageAdapter.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQMultistageCell.h"

@class XQMultistageAdapter, XQNode, XQMultistageTableView;

@protocol XQMultistageAdapterDelegate <NSObject>

@optional

// cell 点击事件
- (void)multistageAdapter:(XQMultistageAdapter *) adapter node:(XQNode *) node didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// 是否关闭子节点
-(BOOL)multistageAdapterShouldCloseSubNode:(XQMultistageAdapter *) adapter;

// 父节点可不可以点击
-(BOOL)multistageAdapterUnClickSuperNode:(XQMultistageAdapter *) adapter didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// 子节点自己显示图片
- (void)multistageAdapter:(XQMultistageAdapter *) adapter tableViewCell:(XQMultistageCell *) cell forRowAtNode:(XQNode *) node;

// 子 自己决定与父标题间距
- (CGFloat)multistageAdapter:(XQMultistageAdapter *) adapter superPiddingAtIndexPath:(NSIndexPath *)indexPath;

// 父标题可以旋转图片
- (UIImage *)multistageAdapter:(XQMultistageAdapter *) adapter customSuperRotationImageAtIndexPath:(NSIndexPath *)indexPath;

// 父标题可以不可以旋转图片
- (UIImage *)multistageAdapter:(XQMultistageAdapter *) adapter customSuperUnRotationImageAtIndexPath:(NSIndexPath *)indexPath;

// 打开选择 属性 选中状态变化
- (void)multistageAdapter:(XQMultistageAdapter *) adapter didSelectedAtIndexPath:(NSIndexPath *)indexPath selected:(BOOL) selected;

// 打开选择 属性 选中状态图片
- (UIImage *)multistageAdapter:(XQMultistageAdapter *) adapter stateSelectedRightImageAtIndexPath:(NSIndexPath *)indexPath;

// 打开选择 属性 未选中状态图片
- (UIImage *)multistageAdapter:(XQMultistageAdapter *) adapter stateNormalRightImageAtIndexPath:(NSIndexPath *)indexPath;

// 是否显示打开选择 属性 选中状态图片
- (BOOL)multistageAdapter:(XQMultistageAdapter *) adapter showStateSelectedRightImageAtIndexPath:(NSIndexPath *)indexPath;

// 是否显示打开选择 属性 未选中状态图片
- (BOOL)multistageAdapter:(XQMultistageAdapter *) adapter showStateNormalRightImageAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XQMultistageAdapter : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<XQMultistageAdapterDelegate> delegate;

@property(nonatomic, weak) NSMutableArray *multistageData;


/**
 单选
 */
@property(nonatomic, assign) BOOL radio;

@property(nonatomic, strong) NSMutableArray<XQNode *> *selectNode;


@end
