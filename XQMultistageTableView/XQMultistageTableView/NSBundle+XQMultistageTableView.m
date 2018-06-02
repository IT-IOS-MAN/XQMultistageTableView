//
//  NSBundle+XQMultistageTableView.m
//  XQMultistageTableView
//
//  Created by Mac_XQ on 2018/6/3.
//  Copyright © 2018年 IT_XQ. All rights reserved.
//

#import "NSBundle+XQMultistageTableView.h"
#import "XQMultistageCell.h"

@implementation NSBundle (XQMultistageTableView)

+ (instancetype)xq_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[XQMultistageCell class]] pathForResource:@"XQMultistageTableView" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)xq_riangleRightImage
{
    static UIImage *riangleRightImage = nil;
    if (riangleRightImage == nil) {
        riangleRightImage = [[UIImage imageWithContentsOfFile:[[self xq_refreshBundle] pathForResource:@"ic_triangle_right@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return riangleRightImage;
}

+ (UIImage *)xq_checkImage
{
    static UIImage *checkImage = nil;
    if (checkImage == nil) {
        checkImage = [[UIImage imageWithContentsOfFile:[[self xq_refreshBundle] pathForResource:@"icon_check@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return checkImage;
}

+ (UIImage *)xq_checkedImage
{
    static UIImage *checkedImage = nil;
    if (checkedImage == nil) {
        checkedImage = [[UIImage imageWithContentsOfFile:[[self xq_refreshBundle] pathForResource:@"icon_checked@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return checkedImage;
}

@end
