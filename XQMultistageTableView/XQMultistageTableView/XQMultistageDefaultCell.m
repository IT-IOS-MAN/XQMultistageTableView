//
//  XQMultistageDefaultCell.m
//  XQMultistageTableView
//
//  Created by 柳钢物流 on 2020/8/6.
//  Copyright © 2020 IT_XQ. All rights reserved.
//

#import "XQMultistageDefaultCell.h"
#import "NSBundle+XQMultistageTableView.h"
#import "XQMultistageConst.h"

@interface XQMultistageCell ()

@property (nonatomic, weak) UITableView * tableView;

@end

@interface XQMultistageDefaultCell ()

/**
 父标题图片是否可以旋转
 */
@property (nonatomic, assign) BOOL superRotationImage;

/**
 选中按钮
 */
@property (nonatomic, weak) UIButton * selectButton;

@end


@implementation XQMultistageDefaultCell

@synthesize delegate = _delegate;

+ (instancetype) multistageCellWithTableView:(UITableView *) tableView
{
    static NSString *cellid = @"XQMultistageDefaultCellId";
    XQMultistageDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[XQMultistageDefaultCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
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
    [selectButton addTarget:self action:@selector(onSelectButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectButton];
    
    _selectButton = selectButton;
}


-(void)setNode:(XQMultistageNode *)node
{
    [super setNode:node];
    
    //如果是部门信息
    if (node.contentType == XQNodeContentTypeSuper) {
        
        if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToRootExpandTipImage:)]) {
            self.imageView.image = [_delegate xq_multistageDefaultCellToRootExpandTipImage:self];
        } else if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToExpandTipImage:)]) {
            self.imageView.image = [_delegate xq_multistageDefaultCellToExpandTipImage:self];
        } else {
            self.imageView.image = nil;
        }
        
        if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToRootExpandTipImageIsRotation:)]) {
            _superRotationImage =  [_delegate xq_multistageDefaultCellToRootExpandTipImageIsRotation:self];
        }
        
        if (!self.imageView.image) {
            self.imageView.image = [NSBundle xq_riangleRightImage];
            _superRotationImage = YES;
        }
        
        self.textLabel.textColor = [UIColor blackColor];
        
    }else if(node.contentType == XQNodeContentTypeSub){
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.imageView.image = nil;
    }
    
    self.textLabel.text = node.title;
    _selectButton.hidden = !node.selectState;
    _selectButton.selected = node.currentSelected;
    
    if (self.radio) {
        __weak typeof(self) weakSelf = self;
        node.selectedStateChange = ^(BOOL currentSelected) {
            weakSelf.selectButton.selected = currentSelected;
        };
    }
    
    
}

// 改变箭头方向
-(void)changeArrowDirection
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
        imageViewWH = self.imageView.image ? XQCommonInset : 0;
    } else {
        imageViewWH = self.imageView.frame.size.width;
    }
    
    CGFloat imageViewX = self.node.depth * XQSuperInset + (imageViewWH > 0 ? XQCommonInset : 0);
    
    if ([self.delegate respondsToSelector:@selector(xq_multistageDefaultCellToContentLeftInset:)]) {
        imageViewX = self.node.depth * [self.delegate xq_multistageDefaultCellToContentLeftInset:self] + (imageViewWH > 0 ? XQCommonInset : 0);
    }
    
    self.imageView.frame = CGRectMake(imageViewX, (cellH - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    self.imageView.layer.cornerRadius = imageViewWH / 2;
    
    CGRect textLabelF = self.textLabel.frame;
    textLabelF.origin.x = CGRectGetMaxX(self.imageView.frame) + XQCommonInset;
    
    if (self.node.selectState) {
        _selectButton.frame = CGRectMake(self.contentView.frame.size.width - cellH, 0, cellH, cellH);
        textLabelF.size.width = _selectButton.frame.origin.x - textLabelF.origin.x - XQCommonInset;
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
- (void)onSelectButtonDidClick:(UIButton *) selectButton
{
    if (self.radio && selectButton.selected) {
        return;
    } else {
        selectButton.selected = !selectButton.selected;
    }
    
    self.node.currentSelected = !self.node.currentSelected;
    
    if ([_delegate respondsToSelector:@selector(xq_multistageCell:imageSelectStateChange:)]) {
        [_delegate xq_multistageCell:self imageSelectStateChange:self.node.currentSelected];
    }
    
    
}

#pragma mark - setting
- (void)setDelegate:(id<XQMultistageDefaultCellDelegate>)delegate
{
    _delegate = delegate;
    
    if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToSelectOperation:)]) {
        
        //
        if ([_delegate xq_multistageDefaultCellToSelectOperation:self]) {
            
            if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToImageStateNormal:)]) {
                [_selectButton setImage:[_delegate xq_multistageDefaultCellToImageStateNormal:self] forState:UIControlStateNormal];
            } else{
                [_selectButton setImage:nil forState:UIControlStateNormal];
            }
            
            if ([_delegate respondsToSelector:@selector(xq_multistageDefaultCellToImageStateSelected:)]) {
                [_selectButton setImage:[_delegate xq_multistageDefaultCellToImageStateSelected:self] forState:UIControlStateSelected];
            } else {
                [_selectButton setImage:nil forState:UIControlStateSelected];
            }
        } else {
            [_selectButton setImage:nil forState:UIControlStateNormal];
            [_selectButton setImage:nil forState:UIControlStateSelected];
        }
    }
}

@end
