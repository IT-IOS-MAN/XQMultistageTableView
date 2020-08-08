//
//  CustomTypeViewCell.m
//  XQMultistageTableView
//
//  Created by 柳钢物流 on 2020/8/8.
//  Copyright © 2020 IT_XQ. All rights reserved.
//

#import "CustomTypeViewCell.h"
#import "XQMultistageConst.h"

@interface CustomTypeViewCell ()

@property (nonatomic, weak) UIView *lineView;

@end

@implementation CustomTypeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupLineView];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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

@end
