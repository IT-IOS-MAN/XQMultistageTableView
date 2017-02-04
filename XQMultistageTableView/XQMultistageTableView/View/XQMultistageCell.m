//
//  XQMultistageCell.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageCell.h"
#import "UIView+XQFrame.h"

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
        
        
        if ([self.delegate respondsToSelector:@selector(multistageCell:isSubShowImageForRowAtIndexPath:)]) {
            
            BOOL showImage = [self.delegate multistageCell:self isSubShowImageForRowAtIndexPath:_indexPath];
            if (showImage) {
                
                if ([self.delegate respondsToSelector:@selector(multistageCell:forRowAtIndexPath:)]) {
                    self.imageView.image = [self.delegate multistageCell:self forRowAtIndexPath:_indexPath];
                    
                }else if([self.delegate respondsToSelector:@selector(multistageCell:imageView:forRowAtIndexPath:)]){
                    [self.delegate multistageCell:self imageView:self.imageView forRowAtIndexPath:_indexPath];
                }

            }
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
        if ([self.delegate respondsToSelector:@selector(multistageCell:isSubShowImageForRowAtIndexPath:)]) {
            BOOL showImage = [self.delegate multistageCell:self isSubShowImageForRowAtIndexPath:_indexPath];
            imageViewWH = (showImage ? (self.contentView.xq_height * 0.7) : 0);
        }else{
            imageViewWH = 0;
        }
    }else if(self.node.contentType == XQNodeContentTypeSuper){
        
        imageViewWH = self.imageView.xq_width;
        
    }
    
    CGFloat imageViewX = self.node.depth * SUPER_PIDDING + (imageViewWH > 0 ? 10 : 0);
    
    if ([self.delegate respondsToSelector:@selector(multistageCellSuperPidding:)]) {
        imageViewX = self.node.depth * [self.delegate multistageCellSuperPidding:self] + (imageViewWH > 0 ? 10 : 0);
    }
    
    self.imageView.frame = CGRectMake(imageViewX, (self.contentView.xq_height - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    self.imageView.layer.cornerRadius = imageViewWH / 2;
    
    // 调整textLabel的frame
    self.textLabel.xq_x = CGRectGetMaxX(self.imageView.frame) + 10;
    
    // 调整分割线的frame
    UIEdgeInsets newSeparatorInset = self.separatorInset;
    newSeparatorInset.left = 0;
    self.separatorInset = newSeparatorInset;

    
    // 改变箭头方向
    [self changeArrowDirection];


}

@end
