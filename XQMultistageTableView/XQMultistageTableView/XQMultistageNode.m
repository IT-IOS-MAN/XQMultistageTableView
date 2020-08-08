//
//  XQMultistageNode.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageNode.h"

@implementation XQMultistageNode

-(NSMutableArray *)subItems
{
    if (!_subItems) {
        _subItems = [NSMutableArray array];
    }
    
    return _subItems;
}

- (void)setCurrentSelected:(BOOL)currentSelected
{
    _currentSelected = currentSelected;
    
    if (_selectedStateChange) {
        _selectedStateChange(currentSelected);
    }
}

@end
