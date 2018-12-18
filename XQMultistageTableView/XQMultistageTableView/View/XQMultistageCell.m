//
//  XQMultistageCell.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageCell.h"
#import "NSBundle+XQMultistageTableView.h"

CGFloat const XQ_SUPER_PIDDING = 20;

@interface XQMultistageCell ()

/**
 父标题图片是否可以旋转
 */
@property (nonatomic, assign) BOOL superRotationImage;


/**
 选中按钮
 */
@property (nonatomic, weak) UIButton * selectButton;


@property (nonatomic, weak) UITableView * tableView;

@end

@implementation XQMultistageCell

+ (instancetype) multistageCellWithTableView:(UITableView *) tableView
{
    static NSString *cellid = @"XQMultistageCellId";
    XQMultistageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[XQMultistageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        cell.tableView = tableView;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置view
        [self setupView];
        
        _superRotationImage = YES;
    }
    return self;
}

/// 设置view
-(void) setupView
{
    self.imageView.clipsToBounds = YES;
    
    [self setupSelectButton];
    
    
    
}

- (void)setupSelectButton
{
    UIButton * selectButton = [[UIButton alloc] init];
    [selectButton addTarget:self action:@selector(selectButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectButton];
    
    _selectButton = selectButton;
}

-(void)setNode:(XQNode *)node
{
    _node = node;
    
    //如果是部门信息
    if (node.contentType == XQNodeContentTypeSuper) {
        
        if ([_delegate respondsToSelector:@selector(xq_multistageCellCustomSuperRotationImage:)]) {
            self.imageView.image = [_delegate xq_multistageCellCustomSuperRotationImage:self];
            _superRotationImage = YES;
        }
        
        if (!self.imageView.image && [_delegate respondsToSelector:@selector(xq_multistageCellCustomSuperUnRotationImage:)]) {
            self.imageView.image =  [_delegate xq_multistageCellCustomSuperUnRotationImage:self];
            _superRotationImage = NO;
        }
        
        if (!self.imageView.image) {
            self.imageView.image = [NSBundle xq_riangleRightImage];
            _superRotationImage = YES;
        }
        
        
        
        self.textLabel.text = node.title;
        
        self.textLabel.textColor = [UIColor blackColor];

        
    }else if(node.contentType == XQNodeContentTypeSub){
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.textLabel.text = node.title;
        
        self.imageView.image = nil;
        
        if([self.delegate respondsToSelector:@selector(xq_multistageCell:forRowAtNode:)]){
            [self.delegate xq_multistageCell:self forRowAtNode:_node];
        }
    }
    
    _selectButton.hidden = !node.selectState;
    _selectButton.selected = node.currentSelected;
    
    if (_radio) {
        __weak typeof(self) weakSelf = self;
        node.selectedStateChange = ^(BOOL currentSelected) {
            weakSelf.selectButton.selected = currentSelected;
        };
    }
    
    
}

// 改变箭头方向
-(void) changeArrowDirection
{
    //旋转 三角形 的小图标
    if (self.node.isExpand) {
        //逆时针转90度
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }else{
        
        //恢复没有旋转的样子
        self.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellH = self.contentView.frame.size.height;
    
    CGFloat imageViewWH;
    
    // 调整imageView的frame
    if (self.node.contentType == XQNodeContentTypeSub) {
        imageViewWH = self.imageView.image ? (cellH * 0.7) : 0;
    } else {
        imageViewWH = self.imageView.frame.size.width;
    }
    
    CGFloat imageViewX = self.node.depth * XQ_SUPER_PIDDING + (imageViewWH > 0 ? 10 : 0);
    
    if ([self.delegate respondsToSelector:@selector(xq_multistageCellSuperPidding:)]) {
        imageViewX = self.node.depth * [self.delegate xq_multistageCellSuperPidding:self] + (imageViewWH > 0 ? 10 : 0);
    }
    
    self.imageView.frame = CGRectMake(imageViewX, (cellH - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    self.imageView.layer.cornerRadius = imageViewWH / 2;
    
    CGRect textLabelF = self.textLabel.frame;
    textLabelF.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    
    if (_node.selectState) {
        _selectButton.frame = CGRectMake(self.contentView.frame.size.width - cellH, 0, cellH, cellH);
        textLabelF.size.width = _selectButton.frame.origin.x - textLabelF.origin.x - 10;
    }
    
    // 调整textLabel的frame
    self.textLabel.frame = textLabelF;
    
    // 调整分割线的frame
    UIEdgeInsets newSeparatorInset = self.separatorInset;
    newSeparatorInset.left = 0;
    self.separatorInset = newSeparatorInset;

    if (_superRotationImage) {
        // 改变箭头方向
        [self changeArrowDirection];
    }
    


}

#pragma mark - 事件
- (void)selectButtonDidClick:(UIButton *) selectButton
{
    if (_radio && selectButton.selected) {
        return;
    } else {
        selectButton.selected = !selectButton.selected;
    }
    
    _node.currentSelected = !_node.currentSelected;
    
    
    if ([_delegate respondsToSelector:@selector(xq_multistageCell:selected:)]) {
        [_delegate xq_multistageCell:self selected:_node.currentSelected];
    }
    
    
}

#pragma mark - setting
- (void)setDelegate:(id<XQMultistageCellDelegate>)delegate
{
    _delegate = delegate;
    
    if ([_delegate respondsToSelector:@selector(xq_multistageCellShowStateNormalRightImage:)]) {
        if ([_delegate xq_multistageCellShowStateNormalRightImage:self]) {
            if ([_delegate respondsToSelector:@selector(xq_multistageCellStateNormalRightImage:)]) {
                [_selectButton setImage:[_delegate xq_multistageCellStateNormalRightImage:self] forState:UIControlStateNormal];
            }
        } else {
            [_selectButton setImage:nil forState:UIControlStateNormal];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(xq_multistageCellShowStateSelectedRightImage:)]) {
        if ([_delegate xq_multistageCellShowStateSelectedRightImage:self]) {
            if ([_delegate respondsToSelector:@selector(xq_multistageCellStateSelectedRight:)]) {
                [_selectButton setImage:[_delegate xq_multistageCellStateSelectedRight:self] forState:UIControlStateSelected];
            }
        } else {
            [_selectButton setImage:nil forState:UIControlStateSelected];
            
        }
    }
}

#pragma mark - getting
- (NSIndexPath *)indexPath
{
    return [_tableView indexPathForCell:self];
}

@end
