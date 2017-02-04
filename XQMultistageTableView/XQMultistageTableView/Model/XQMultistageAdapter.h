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

-(void)multistageAdapter:(XQMultistageAdapter *) adapter node:(XQNode *) node didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// 是否关闭子节点(目前没有实现)
-(BOOL)multistageAdapterShouldCloseSubNode:(XQMultistageAdapter *) adapter;

@end

@interface XQMultistageAdapter : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<XQMultistageAdapterDelegate, XQMultistageCellDelegate> delegate;

@property(nonatomic, weak) NSMutableArray *multistageData;

@end
