//
//  XQMultistageDefaultAdapter.m
//  XQMultistageTableView
//
//  Created by 柳钢物流 on 2020/8/6.
//  Copyright © 2020 IT_XQ. All rights reserved.
//

#import "XQMultistageDefaultAdapter.h"
#import "XQMultistageDefaultCell.h"
#import "XQMultistageConst.h"
#import "NSBundle+XQMultistageTableView.h"

@interface XQMultistageDefaultAdapter () <XQMultistageDefaultCellDelegate>

// 选中图片
@property(nonatomic, strong) UIImage * checkedImage;

// 未选中图片
@property(nonatomic, strong) UIImage * checkImage;

// 根节点图片
@property(nonatomic, strong) UIImage * rootExpandTipImage;

// 节点图片
@property(nonatomic, strong) UIImage * expandTipImage;

@end

@implementation XQMultistageDefaultAdapter

@synthesize delegate = _delegate;

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQMultistageDefaultCell *cell = [XQMultistageDefaultCell multistageCellWithTableView:tableView];
    cell.type = XQMultistageCellTypeSystem;
    
    cell.delegate = self;
    
    cell.radio = self.radio;
    
    cell.node = self.multistageData[indexPath.row];
    
    return cell;
    
}

#pragma mark - XQMultistageDefaultCellDelegate

// 自定义内容左边内边距
// 可通过 XQMultistageNode -> depth 获取到当前层级决定缩紧长度
- (CGFloat)xq_multistageDefaultCellToContentLeftInset:(XQMultistageDefaultCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToContentLeftInset:)]) {
        return [_delegate xq_multistageDefaultAdapterToContentLeftInset:self];
    }
    return XQSuperInset;
}

/**
 * 多级展示节点展开提示图片功能代理
 * 节点展开提示 是在 Cell 的左边
 */

// 根节点展开提示图片图片
- (UIImage *)xq_multistageDefaultCellToRootExpandTipImage:(XQMultistageDefaultCell *) cell
{
    if (_rootExpandTipImage) {
        return _rootExpandTipImage;
    }
    
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToRootExpandTipImage:)]) {
        _rootExpandTipImage = [_delegate xq_multistageDefaultAdapterToRootExpandTipImage:self];
    }
    return _rootExpandTipImage;
}

// 节点展开提示图片
- (UIImage *)xq_multistageDefaultCellToExpandTipImage:(XQMultistageDefaultCell *) cell
{
    if (_expandTipImage) {
        return _expandTipImage;
    }
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToExpandTipImage:)]) {
        _expandTipImage = [_delegate xq_multistageDefaultAdapterToExpandTipImage:self];
    }
    return nil;
}

// 根节点展开提示图片 是否可以旋转
- (BOOL)xq_multistageDefaultCellToRootExpandTipImageIsRotation:(XQMultistageDefaultCell *) cell;
{
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToRootExpandTipImageIsRotation:)]) {
        return [_delegate xq_multistageDefaultAdapterToRootExpandTipImageIsRotation:self];
    }
    return YES;
}

/**
 * 多级展示选择功能代理
 * 节点选择图片是在 Cell 的右边
 */

// 是否启用选择展示功能
- (BOOL)xq_multistageDefaultCellToSelectOperation:(XQMultistageDefaultCell *) cell
{
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToSelectOperation:)]) {
        return [_delegate xq_multistageDefaultAdapterToSelectOperation:self];
    }
    
    return YES;
}

// 选择展示功能 -> 选中状态图片
- (UIImage *)xq_multistageDefaultCellToImageStateSelected:(XQMultistageDefaultCell *) cell;
{
    if (_checkedImage) {
        return _checkedImage;
    }
    
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToImageStateSelected:)]) {
        _checkedImage = [_delegate xq_multistageDefaultAdapterToImageStateSelected:self];
    } else {
        _checkedImage = [NSBundle xq_checkedImage];
    }
    
    return _checkedImage;
}

// 选择展示功能 -> 未选中状态图片
- (UIImage *)xq_multistageDefaultCellToImageStateNormal:(XQMultistageDefaultCell *) cell;
{
    if (_checkImage) {
        return _checkImage;
    }
    
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultAdapterToImageStateNormal:)]) {
        _checkImage = [_delegate xq_multistageDefaultAdapterToImageStateNormal:self];
    } else {
        _checkImage = [NSBundle xq_checkImage];
    }
    
    return _checkImage;
}

//-(void)setDelegate:(id<XQMultistageDefaultAdapterDelegate>)delegate
//{
//    super.delegate = delegate;
//    _delegate = delegate;
//}
@end
