//
//  XQMultistageDefaultAdapter.h
//  XQMultistageTableView
//
//  Created by 柳钢物流 on 2020/8/6.
//  Copyright © 2020 IT_XQ. All rights reserved.
//

#import "XQMultistageAdapter.h"

@class XQMultistageDefaultAdapter;

@protocol XQMultistageDefaultAdapterDelegate <NSObject, XQMultistageAdapterDelegate>

@optional



// 自定义内容左边内边距
// 可通过 XQMultistageNode -> depth 获取到当前层级决定缩紧长度
- (CGFloat)xq_multistageDefaultAdapterToContentLeftInset:(XQMultistageDefaultAdapter *) adapter;

/**
 * 多级展示节点展开提示图片功能代理
 * 节点展开提示 是在 Cell 的左边
 */

// 根节点展开提示图片图片
- (UIImage *)xq_multistageDefaultAdapterToRootExpandTipImage:(XQMultistageDefaultAdapter *) adapter;

// 节点展开提示图片图片
- (UIImage *)xq_multistageDefaultAdapterToExpandTipImage:(XQMultistageDefaultAdapter *) adapter;

// 根节点展开提示图片 是否可以旋转
- (BOOL)xq_multistageDefaultAdapterToRootExpandTipImageIsRotation:(XQMultistageDefaultAdapter *) adapter;

/**
 * 多级展示选择功能代理
 * 节点选择图片是在 Cell 的右边
 */

// 是否启用选择展示功能 配合 XQMultistageNode->selectState 使用
- (BOOL)xq_multistageDefaultAdapterToSelectOperation:(XQMultistageDefaultAdapter *) adapter;

// 选择展示功能 -> 选中状态图片
- (UIImage *)xq_multistageDefaultAdapterToImageStateSelected:(XQMultistageDefaultAdapter *) adapter;

// 选择展示功能 -> 未选中状态图片
- (UIImage *)xq_multistageDefaultAdapterToImageStateNormal:(XQMultistageDefaultAdapter *) adapter;


@end

@interface XQMultistageDefaultAdapter : XQMultistageAdapter

// 代理
@property(nonatomic, weak) id<XQMultistageDefaultAdapterDelegate> delegate;

@end


