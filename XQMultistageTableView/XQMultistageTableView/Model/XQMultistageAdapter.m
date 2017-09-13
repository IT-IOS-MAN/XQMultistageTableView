//
//  XQMultistageAdapter.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageAdapter.h"

@interface XQMultistageAdapter () 


@end

@implementation XQMultistageAdapter

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _multistageData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQMultistageCell *cell = [XQMultistageCell multistageCellWithTableView:tableView];
    
    cell.delegate = _delegate;
    
    cell.indexPath = indexPath;
    
    cell.node = _multistageData[indexPath.row];

    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XQNode *node = self.multistageData[indexPath.row];
    
    // 如果是人员就直接跳转到详细页面
    if (node.contentType == XQNodeContentTypeSub) {
        
        if ([self.delegate respondsToSelector:@selector(multistageAdapter:node:didSelectRowAtIndexPath:)]) {
            [self.delegate multistageAdapter:self node:node didSelectRowAtIndexPath:indexPath];
        }
        
        return;
    }
    
    // 如果是部门就展开 或 收起
    if (node.contentType == XQNodeContentTypeSuper) {
        
        // 展开
        if (!node.isExpand) {
            
            node.isExpand = !node.isExpand;
            
            if (node.subItems.count > 0) {
                NSMutableArray * arr = [NSMutableArray array];
                
                for (int i = 1; i <= node.subItems.count; i++) {
                    
                    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
                    [arr addObject:newIndexPath];
                    
                    [self.multistageData insertObject:node.subItems[i - 1] atIndex:indexPath.row + i];
                    
                }
                
                [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
                
            }
            
            // 移动cell
            
            XQMultistageCell *cell = (XQMultistageCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            
            if (cell.frame.origin.y - tableView.contentOffset.y + tableView.separatorInset.top > tableView.frame.size.height * 0.6) {
                
                
                
                if (cell.frame.origin.y - tableView.frame.size.height * 0.5 <  tableView.contentSize.height - cell.frame.origin.y) {
                    
                    if(tableView.tableHeaderView.frame.size.height + self.multistageData.count * tableView.rowHeight > tableView.frame.size.height){
                        [UIView animateWithDuration:0.5 animations:^{
                            
                            tableView.contentOffset = CGPointMake(0, cell.frame.origin.y - tableView.frame.size.height * 0.5);
                            
                        }];
                    }
                    
                    
                }else{  // 如果tableView的 contentSize.height
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.multistageData.count - 1 inSection:0];
                    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
                
                
                
            }
            
        }else{ //关闭
            
            // 获取全部全部子节点的数量
            int closeAllCount = (int)[self closeAllChildNode:node];
            
            if (closeAllCount > 0) {
                NSMutableArray * arr = [NSMutableArray array];
                
                for (int i = 1; i <= closeAllCount; i++) {
                    
                    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
                    [arr addObject:newIndexPath];
                    
                    [self.multistageData removeObjectAtIndex:indexPath.row + 1];
                    
                }
                
                [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
                
            }
            
        }
        
        //        [self.tableView reloadData];
        
    }
}

/// 关闭全部子节点
- (long) closeAllChildNode:(XQNode *) node
{
    
    long closeAllCount = 0;
    
    
    if(node.isExpand){
        
        for (int i = 0; i < node.subItems.count; i++) {
            
            closeAllCount += [self closeAllChildNode:node.subItems[i]];
        }
        
    }
    
    if (node.isExpand) {
        
        node.isExpand = !node.isExpand;
        
        closeAllCount += node.subItems.count;
    }
    
    return closeAllCount;
}

@end
