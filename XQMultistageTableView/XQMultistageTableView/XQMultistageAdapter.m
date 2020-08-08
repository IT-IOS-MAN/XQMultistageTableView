//
//  XQMultistageAdapter.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageAdapter.h"
#import "NSBundle+XQMultistageTableView.h"
#import "XQMultistageConst.h"

@interface XQMultistageAdapter ()<XQMultistageCellDelegate>

@property(nonatomic, assign) BOOL closeSubNode;

@end

@implementation XQMultistageAdapter

- (instancetype)init
{
    if (self = [super init]){
        [self delegate];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _multistageData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQMultistageCell *cell = nil;
    
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:tableView:cellForRowAtIndexPath:)]) {
        cell = [_delegate xq_multistageAdapter:self tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.type = XQMultistageCellTypeCustom;
    } else {
        cell = [XQMultistageCell multistageCellWithTableView:tableView];
        cell.type = XQMultistageCellTypeSystem;
    }
    
    cell.delegate = self;
    
    cell.radio = _radio;
    
    cell.node = _multistageData[indexPath.row];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:heightForRowAtNode:)]) {
        return [_delegate xq_multistageAdapter:self heightForRowAtNode:_multistageData[indexPath.row]];
    }
    return XQCommonItemHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XQMultistageNode *node = self.multistageData[indexPath.row];
    
    // 如果是人员就直接跳转到详细页面
    if (node.contentType == XQNodeContentTypeSub) {
        
        if ([self.delegate respondsToSelector:@selector(xq_multistageAdapter:didSelectRowAtNode:)]) {
            [self.delegate xq_multistageAdapter:self didSelectRowAtNode:node];
        }
        
        return;
    } else if (node.contentType == XQNodeContentTypeSuper) {
        if ([self.delegate respondsToSelector:@selector(xq_multistageAdapterUnClickSuperNode:)]) {
            if ( [self.delegate xq_multistageAdapterUnClickSuperNode:self]) {
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
- (void)xq_multistageCell:(XQMultistageCell *) cell imageSelectStateChange:(BOOL) selected
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
    
    if ([_delegate respondsToSelector:@selector(xq_multistageAdapter:didSelectStateChangeAtNode:selectState:)]) {
        [_delegate xq_multistageAdapter:self didSelectStateChangeAtNode:cell.node selectState:selected];
    }
    
}


#pragma mark - Func

/// 关闭全部子节点
- (long) closeAllChildNode:(XQMultistageNode *) node
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
- (long) getAllChildNode:(XQMultistageNode *) node
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
- (NSMutableArray<XQMultistageNode *> *) getAllOpenChildNode:(XQMultistageNode *) node
{
    
    NSMutableArray<XQMultistageNode *> * nodes = [NSMutableArray array];
    
    
    if(node.isExpand){
        
        [nodes addObjectsFromArray:node.subItems];
        
        for (int i = 0; i < node.subItems.count; i++) {
            
            [nodes addObjectsFromArray:[self getAllOpenChildNode:node.subItems[i]]];
        }
    }
    
    return nodes;
}


- (void)insertOpenDateWithTableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath openNode:(XQMultistageNode *) node
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

- (void)deleteCloseDateWithTableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cleseNode:(XQMultistageNode *) node
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

#pragma mark - setting
- (void)setMultistageData:(NSMutableArray<XQMultistageNode *> *)multistageData
{
    _multistageData = multistageData;
    
    NSMutableArray<XQMultistageNode *> * copyMultistageData = [multistageData mutableCopy];
    
    for (XQMultistageNode * node in copyMultistageData) {
        
        NSInteger index = [multistageData indexOfObject:node];
        
        if (node.isExpand) {
            NSArray *subArrray = [self getAllOpenChildNode:node];
            
            [self.multistageData insertObjects:subArrray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index + 1, subArrray.count)]];

        }
    }
}

#pragma mark - getting

- (NSMutableArray<XQMultistageNode *> *)selectNode
{
    if (!_selectNode) {
        _selectNode = [NSMutableArray array];
    }
    
    return _selectNode;
}

@end
