//
//  UIView+XQFrame.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "UIView+XQFrame.h"

@implementation UIView (XQFrame)

- (void)setXq_width:(CGFloat)xq_width
{
    CGRect frame = self.frame;
    frame.size.width = xq_width;
    self.frame = frame;
}

- (void)setXq_height:(CGFloat)xq_height
{
    CGRect frame = self.frame;
    frame.size.height = xq_height;
    self.frame = frame;
}

- (void)setXq_x:(CGFloat)xq_x
{
    CGRect frame = self.frame;
    frame.origin.x = xq_x;
    self.frame = frame;
}

- (void)setXq_y:(CGFloat)xq_y
{
    CGRect frame = self.frame;
    frame.origin.y = xq_y;
    self.frame = frame;
}

- (CGFloat)xq_width
{
    return self.frame.size.width;
}

- (CGFloat)xq_height
{
    return self.frame.size.height;
}

- (CGFloat)xq_x
{
    return self.frame.origin.x;
}

- (CGFloat)xq_y
{
    return self.frame.origin.y;
}

@end
