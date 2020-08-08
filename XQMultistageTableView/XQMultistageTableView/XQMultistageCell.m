//
//  XQMultistageCell.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "XQMultistageCell.h"
#import "XQMultistageConst.h"


@interface XQMultistageCell ()

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, weak) UIView *lineView;

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
        
        if (_type == XQMultistageCellTypeSystem) {
            [self setupLineView];
        }
        
    }
    return self;
}

- (void)setupLineView
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.contentView addSubview:lineView];
    _lineView = lineView;
}

-(void)setNode:(XQMultistageNode *)node
{
    _node = node;
    
    self.textLabel.text = node.title;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_type == XQMultistageCellTypeSystem) {
        
        CGRect textLabelF = self.textLabel.frame;
        textLabelF.origin.x = self.node.depth * XQSuperInset + XQCommonInset;
        
        // 调整textLabel的frame
        self.textLabel.frame = textLabelF;
        
        // 调整分割线的frame
        
        CGRect lineViewF = self.lineView.frame;
        lineViewF.origin.x = self.node.depth * XQSuperInset;
        lineViewF.origin.y = self.contentView.frame.size.height - lineViewF.size.height;
        lineViewF.size.width = self.contentView.frame.size.width - lineViewF.origin.x;
        self.lineView.frame = lineViewF;
    }
}

#pragma mark - getting
- (NSIndexPath *)indexPath
{
    return [_tableView indexPathForCell:self];
}

@end
