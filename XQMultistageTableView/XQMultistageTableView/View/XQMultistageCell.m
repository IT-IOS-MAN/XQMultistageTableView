//
//  XQMultistageCell.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageCell.h"

static CGFloat SUPER_PIDDING = 20;

@interface XQMultistageCell ()

@end

@implementation XQMultistageCell

+ (instancetype) multistageCellWithTableView:(UITableView *) tableView
{
    static NSString *cellid = @"XQMultistageCellId";
    XQMultistageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[XQMultistageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置view
        [self setupView];
    }
    return self;
}

/// 设置view
-(void) setupView
{
    self.imageView.clipsToBounds = YES;
    
}

-(void)setNode:(XQNode *)node
{
    _node = node;
    
    //如果是部门信息
    if (node.contentType == XQNodeContentTypeSuper) {
        
        self.imageView.image = [UIImage imageNamed:@"ic_triangle_right"];
        
        self.textLabel.text = node.title;
        
        self.textLabel.textColor = [UIColor blackColor];

        
    }else if(node.contentType == XQNodeContentTypeSub){
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.textLabel.text = node.title;
        
        self.imageView.image = nil;
        
        if([self.delegate respondsToSelector:@selector(multistageCell:imageView:forRowAtNode:)]){
            [self.delegate multistageCell:self imageView:self.imageView forRowAtNode:_node];
        }
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
    
    CGFloat imageViewWH;
    
    // 调整imageView的frame
    if (self.node.contentType == XQNodeContentTypeSub) {
        imageViewWH = self.imageView.image ? (self.contentView.frame.size.height * 0.7) : 0;
//    }else if(self.node.contentType == XQNodeContentTypeSuper){
    } else {
        imageViewWH = self.imageView.frame.size.width;
    }
    
    CGFloat imageViewX = self.node.depth * SUPER_PIDDING + (imageViewWH > 0 ? 10 : 0);
    
    if ([self.delegate respondsToSelector:@selector(multistageCellSuperPidding:)]) {
        imageViewX = self.node.depth * [self.delegate multistageCellSuperPidding:self] + (imageViewWH > 0 ? 10 : 0);
    }
    
    self.imageView.frame = CGRectMake(imageViewX, (self.contentView.frame.size.height - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    self.imageView.layer.cornerRadius = imageViewWH / 2;
    
    // 调整textLabel的frame
    CGRect textLabelF = self.textLabel.frame;
    textLabelF.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    self.textLabel.frame = textLabelF;
    
    // 调整分割线的frame
    UIEdgeInsets newSeparatorInset = self.separatorInset;
    newSeparatorInset.left = 0;
    self.separatorInset = newSeparatorInset;

    
    // 改变箭头方向
    [self changeArrowDirection];


}

@end
