//
//  XQMultistageCell.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQNode.h"

UIKIT_EXTERN CGFloat const XQ_SUPER_PIDDING;

@class XQMultistageCell;

@protocol XQMultistageCellDelegate <NSObject>

@optional

// 子 自己决定怎么显示图片
- (void)multistageCell:(XQMultistageCell *) cell forRowAtNode:(XQNode *) node;

// 子 自己决定与父标题间距
- (CGFloat)multistageCellSuperPidding:(XQMultistageCell *) cell;

// 父标题可以旋转图片
- (UIImage *)multistageCellCustomSuperRotationImage:(XQMultistageCell *) cell;

// 父标题可以不可以旋转图片
- (UIImage *)multistageCellCustomSuperUnRotationImage:(XQMultistageCell *) cell;

// 右边状态改变
- (void)multistageCell:(XQMultistageCell *) cell selected:(BOOL) selected;

// 打开选择 属性 选中状态图片
- (UIImage *)multistageCellStateSelectedRight:(XQMultistageCell *) cell;

// 打开选择 属性 未选中状态图片
- (UIImage *)multistageCellStateNormalRightImage:(XQMultistageCell *) cell;

// 是否显示打开选择 属性 选中状态图片
- (BOOL)multistageCellShowStateSelectedRightImage:(XQMultistageCell *) cell;

// 是否显示打开选择 属性 未选中状态图片
- (BOOL)multistageCellShowStateNormalRightImage:(XQMultistageCell *) cell;

@end

@interface XQMultistageCell : UITableViewCell

+ (instancetype) multistageCellWithTableView:(UITableView *) tableView;

@property(nonatomic, weak) id<XQMultistageCellDelegate> delegate;

@property(nonatomic, assign) BOOL radio;

@property(nonatomic, strong) XQNode * node;

@property(nonatomic, weak, readonly) NSIndexPath *indexPath;

@end
