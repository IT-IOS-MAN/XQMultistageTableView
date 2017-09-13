//
//  XQMultistageCell.h
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQNode.h"

@class XQMultistageCell;

@protocol XQMultistageCellDelegate <NSObject>

@optional

// 子 自己决定怎么显示图片
- (void)multistageCell:(XQMultistageCell *) cell imageView:(UIImageView *) imageView forRowAtNode:(XQNode *) node;

// 子 自己决定与父标题间距
- (CGFloat)multistageCellSuperPidding:(XQMultistageCell *) cell;

@end

@interface XQMultistageCell : UITableViewCell

+ (instancetype) multistageCellWithTableView:(UITableView *) tableView;

@property(nonatomic, weak) id<XQMultistageCellDelegate> delegate;

@property(nonatomic, strong) XQNode * node;

@property(nonatomic, weak) NSIndexPath *indexPath;

@end
