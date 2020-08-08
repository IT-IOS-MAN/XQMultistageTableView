//
//  XQMultistageCell.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQMultistageNode.h"

@class XQMultistageCell;

typedef enum{
    XQMultistageCellTypeSystem, // 使用 XQMultistageCell
    XQMultistageCellTypeCustom, // 自定义
} XQMultistageCellType;

@protocol XQMultistageCellDelegate <NSObject>

@optional

/**
 * 多级展示选择功能代理
 */

// 选择展示功能 -> 状态改变
// 如果继承类需要自定义Cell现在y有选择功能，在选择事件中手动调用改方法，
// XQMultistageAdapter类中会自动完成单选和多选功能，但自定的选择按钮需要继承类完成按钮的是否选择的图片显示
- (void)xq_multistageCell:(XQMultistageCell *) cell imageSelectStateChange:(BOOL) selected;

@end

@interface XQMultistageCell : UITableViewCell

/**
 * 快速初始化
 */
+ (instancetype) multistageCellWithTableView:(UITableView *) tableView;

// 代理
@property(nonatomic, weak) id<XQMultistageCellDelegate> delegate;

// cell 的类型
@property(nonatomic, assign) XQMultistageCellType type;

// 模型
@property(nonatomic, strong) XQMultistageNode * node;

// 是否是单选
// 在 xq_multistageCellToSelectedStateImage 设置为 YES 时有效
@property(nonatomic, assign) BOOL radio;

// Cell 位置信息
@property(nonatomic, weak, readonly) NSIndexPath *indexPath;

@end
