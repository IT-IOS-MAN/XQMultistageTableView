//
//  XQMultistageDefaultCell.h
//  XQMultistageTableView
//
//  Created by 柳钢物流 on 2020/8/6.
//  Copyright © 2020 IT_XQ. All rights reserved.
//

#import "XQMultistageCell.h"

@class XQMultistageDefaultCell;

@protocol XQMultistageDefaultCellDelegate <XQMultistageCellDelegate>

@optional

/**
 * 多级展示节点展开提示图片功能代理
 */

// 自定义内容左边内边距
// 可通过 XQMultistageNode -> depth 获取到当前层级决定缩紧长度
- (CGFloat)xq_multistageDefaultCellToContentLeftInset:(XQMultistageDefaultCell *) cell;


/**
 * 多级展示节点展开提示图片功能代理
 * 节点展开提示 是在 Cell 的左边
 */

// 根节点展开提示图片图片
- (UIImage *)xq_multistageDefaultCellToRootExpandTipImage:(XQMultistageDefaultCell *) cell;

// 节点展开提示图片
- (UIImage *)xq_multistageDefaultCellToExpandTipImage:(XQMultistageDefaultCell *) cell;

// 根节点展开提示图片 是否可以旋转
- (BOOL)xq_multistageDefaultCellToRootExpandTipImageIsRotation:(XQMultistageDefaultCell *) cell;


/**
 * 多级展示选择功能代理
 * 节点选择图片是在 Cell 的右边
 */

// 是否启用选择展示功能
- (BOOL)xq_multistageDefaultCellToSelectOperation:(XQMultistageDefaultCell *) cell;

// 选择展示功能 -> 选中状态图片
- (UIImage *)xq_multistageDefaultCellToImageStateSelected:(XQMultistageDefaultCell *) cell;

// 选择展示功能 -> 未选中状态图片
- (UIImage *)xq_multistageDefaultCellToImageStateNormal:(XQMultistageDefaultCell *) cell;

@end

@interface XQMultistageDefaultCell : XQMultistageCell

// 代理
@property(nonatomic, weak) id<XQMultistageDefaultCellDelegate> delegate;

@end


