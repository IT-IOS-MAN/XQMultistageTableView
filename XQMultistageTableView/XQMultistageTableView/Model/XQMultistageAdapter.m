//
//  XQMultistageAdapter.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageAdapter.h"
#import "NSBundle+XQMultistageTableView.h"

@interface XQMultistageAdapter () <XQMultistageCellDelegate>

@property(nonatomic, assign) BOOL closeSubNode;

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
    
    cell.delegate = self;
    
    cell.radio = _radio;
    
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
        
        if ([self.delegate respondsToSelector:@selector(xq_multistageAdapter:node:didSelectRowAtIndexPath:)]) {
            [self.delegate xq_multistageAdapter:self node:node didSelectRowAtIndexPath:indexPath];
        }
        
        return;
    } else if (node.contentType == XQNodeContentTypeSuper) {
        if ([self.delegate respondsToSelector:@selector(xq_multistageAdapterUnClickSuperNode:didSelectRowAtIndexPath:)]) {
            if ( [self.delegate xq_multistageAdapterUnClickSuperNode:self didSelectRowAtIndexPath:indexPath]) {
                return;
            }
        }
    }
    // 是否关闭子节点
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapterShouldCloseSubNode:)]) {
        _closeSubNode = [_delegate xq_multistageAdapterShouldCloseSubNode:self];
    }
    
    // 如果是部门就展开 或 收起
    if (node.contentType == XQNodeContentTypeSuper) {
        
        // 展开
        if (!node.isExpand) {
            
            node.isExpand = !node.isExpand;
            
            // 插入要打开的数据
            [self insertOpenDateWithTableView:tableView cellForRowAtIndexPath:indexPath openNode:node];
            
            
            // 移动cell
            [self moveCellAutoWithTableView:tableView cellForRowAtIndexPath:indexPath];
            
            
        }else{ //关闭
            // 删除要关闭的数据
            [self deleteCloseDateWithTableView:tableView cellForRowAtIndexPath:indexPath cleseNode:node];
        }
        
        
    }
}

#pragma mark - XQMultistageCellDelegate
// 子 自己决定怎么显示图片
- (void)xq_multistageCell:(XQMultistageCell *) cell forRowAtNode:(XQNode *)node
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:tableViewCell:forRowAtNode:)]) {
        [_delegate xq_multistageAdapter:self tableViewCell:cell forRowAtNode:node];
    }
}

// 子 自己决定与父标题间距
- (CGFloat)xq_multistageCellSuperPidding:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:superPiddingAtIndexPath:)]) {
        [_delegate xq_multistageAdapter:self superPiddingAtIndexPath:cell.indexPath];
    }
    return XQ_SUPER_PIDDING;
}

// 父标题可以旋转图片
- (UIImage *)xq_multistageCellCustomSuperRotationImage:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:customSuperRotationImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self customSuperRotationImageAtIndexPath:cell.indexPath];
    }
    return nil;
}

// 父标题可以不可以旋转图片
- (UIImage *)xq_multistageCellCustomSuperUnRotationImage:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:customSuperUnRotationImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self customSuperUnRotationImageAtIndexPath:cell.indexPath];
    }
    return nil;
}

- (void)xq_multistageCell:(XQMultistageCell *) cell selected:(BOOL) selected
{
    
    if (_radio) {
        self.selectNode.firstObject.currentSelected = NO;
        [self.selectNode removeAllObjects];
        [self.selectNode addObject:cell.node];
    } else {
        if ([self.selectNode containsObject:cell.node]) {
            [self.selectNode removeObject:cell.node];
        } else {
            [self.selectNode addObject:cell.node];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:didSelectedAtIndexPath:selected:)]) {
        [_delegate xq_multistageAdapter:self didSelectedAtIndexPath:cell.indexPath selected:selected];
    }
    
}

// 打开选择 属性 选中状态图片
- (UIImage *)xq_multistageCellStateSelectedRight:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:stateSelectedRightImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self stateSelectedRightImageAtIndexPath:cell.indexPath];
    }
    
    return [NSBundle xq_checkedImage];
}

// 打开选择 属性 未选中状态图片
- (UIImage *)xq_multistageCellStateNormalRightImage:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:stateNormalRightImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self stateNormalRightImageAtIndexPath:cell.indexPath];
    }
    
    return [NSBundle xq_checkImage];
}

// 是否显示打开选择 属性 选中状态图片
- (BOOL)xq_multistageCellShowStateSelectedRightImage:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:showStateSelectedRightImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self showStateSelectedRightImageAtIndexPath:cell.indexPath];
    }
    
    return YES;
}

// 是否显示打开选择 属性 未选中状态图片
- (BOOL)xq_multistageCellShowStateNormalRightImage:(XQMultistageCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:showStateNormalRightImageAtIndexPath:)]) {
        return [_delegate xq_multistageAdapter:self showStateNormalRightImageAtIndexPath:cell.indexPath];
    }
    
    return YES;
}



#pragma mark - Func

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

/// 获取该节点没有关闭的全部子节点
- (long) getAllChildNode:(XQNode *) node
{
    
    long closeAllCount = 0;
    
    
    if(node.isExpand){
        
        for (int i = 0; i < node.subItems.count; i++) {
            
            closeAllCount += [self getAllChildNode:node.subItems[i]];
        }
        
    }
    
    if (node.isExpand) {
        
        closeAllCount += node.subItems.count;
    }
    
    return closeAllCount;
}

/// 获取该节点没有将要打开的全部子节点
- (NSMutableArray<XQNode *> *) getAllOpenChildNode:(XQNode *) node
{
    
    NSMutableArray<XQNode *> * nodes = [NSMutableArray array];
    
    
    if(node.isExpand){
        
        [nodes addObjectsFromArray:node.subItems];
        
        for (int i = 0; i < node.subItems.count; i++) {
            
            [nodes addObjectsFromArray:[self getAllOpenChildNode:node.subItems[i]]];
        }
        
    }
    
    return nodes;
}


- (void)insertOpenDateWithTableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath openNode:(XQNode *) node
{
    if (node.subItems.count > 0) {
        NSMutableArray * arr = [NSMutableArray array];
        
        NSArray *forArrray;
        
        if (_closeSubNode) {
            forArrray = node.subItems;
        } else {
            forArrray = [self getAllOpenChildNode:node];
        }
        
        [self.multistageData insertObjects:forArrray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, forArrray.count)]];
        
        for (int i = 1; i <= forArrray.count; i++) {
            
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
            [arr addObject:newIndexPath];
            
        }
        
        [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        
    }

}

- (void)deleteCloseDateWithTableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cleseNode:(XQNode *) node
{
    int closeAllCount;
    if (_closeSubNode) {
        // 获取全部全部子节点的数量
        closeAllCount = (int)[self closeAllChildNode:node];
    } else {
        closeAllCount = (int)[self getAllChildNode:node];
        node.isExpand = !node.isExpand;
    }
    
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

#pragma mark - setupUI

- (void)moveCellAutoWithTableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
}

#pragma mark - getting

- (NSMutableArray<XQNode *> *)selectNode
{
    if (!_selectNode) {
        _selectNode = [NSMutableArray array];
    }
    
    return _selectNode;
}

@end
