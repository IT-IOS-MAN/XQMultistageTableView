//
//  XQNode.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQNode.h"

@implementation XQNode

-(NSMutableArray *)subItems
{
    if (!_subItems) {
        _subItems = [NSMutableArray array];
    }
    
    return _subItems;
}

@end
