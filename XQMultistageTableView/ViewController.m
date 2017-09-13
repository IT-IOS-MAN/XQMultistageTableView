//
//  ViewController.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "ViewController.h"
#import "XQMultistageAdapter.h"
#import "XQNode.h"

@interface ViewController ()<XQMultistageCellDelegate, XQMultistageAdapterDelegate>

@property(nonatomic, strong) NSMutableArray *data;

@property(nonatomic, strong) XQMultistageAdapter *adapter;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adapter = [[XQMultistageAdapter alloc] init];
    _adapter.delegate = self;
    _adapter.multistageData = self.data;
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];
}

#pragma mark - XQMultistageCellDelegate

-(CGFloat)multistageCellSuperPidding:(XQMultistageCell *)cell
{
    return 30;
}

-(void)multistageCell:(XQMultistageCell *)cell imageView:(UIImageView *)imageView forRowAtNode:(XQNode *)node
{
    if (node.imagePath.length) {
        imageView.image = [UIImage imageNamed:node.imagePath];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSMutableArray *)data
{
    if (!_data) {
        
        _data = [NSMutableArray array];
        //--------1--------
        XQNode *nodeSuper1 = [[XQNode alloc] init];
        nodeSuper1.contentType = XQNodeContentTypeSuper;
        nodeSuper1.depth = 0;
        nodeSuper1.title = @"Super1";
        [_data addObject:nodeSuper1];
        
        XQNode *nodesub1_1 = [[XQNode alloc] init];
        nodesub1_1.contentType = XQNodeContentTypeSub;
        nodesub1_1.depth = 1;
        nodesub1_1.title = @"nodesub1_1";
        [nodeSuper1.subItems addObject:nodesub1_1];
        
        XQNode *nodesub1_2 = [[XQNode alloc] init];
        nodesub1_2.contentType = XQNodeContentTypeSub;
        nodesub1_2.depth = 1;
        nodesub1_2.title = @"nodesub1_2";
        [nodeSuper1.subItems addObject:nodesub1_2];
        
        XQNode *nodesub1_3 = [[XQNode alloc] init];
        nodesub1_3.contentType = XQNodeContentTypeSub;
        nodesub1_3.depth = 1;
        nodesub1_3.title = @"nodesub1_3";
        [nodeSuper1.subItems addObject:nodesub1_3];
        
        XQNode *nodeSuper1_4 = [[XQNode alloc] init];
        nodeSuper1_4.contentType = XQNodeContentTypeSuper;
        nodeSuper1_4.depth = 1;
        nodeSuper1_4.title = @"nodeSuper1_4";
        [nodeSuper1.subItems addObject:nodeSuper1_4];
        
        XQNode *nodeSuper1_4_1 = [[XQNode alloc] init];
        nodeSuper1_4_1.contentType = XQNodeContentTypeSub;
        nodeSuper1_4_1.depth = 2;
        nodeSuper1_4_1.title = @"nodeSuper1_4_1";
        [nodeSuper1_4.subItems addObject:nodeSuper1_4_1];
        
        XQNode *nodeSuper1_4_2 = [[XQNode alloc] init];
        nodeSuper1_4_2.contentType = XQNodeContentTypeSuper;
        nodeSuper1_4_2.depth = 2;
        nodeSuper1_4_2.title = @"nodeSuper1_4_2";
        [nodeSuper1_4.subItems addObject:nodeSuper1_4_2];
        
        XQNode *nodeSuper1_4_2_1 = [[XQNode alloc] init];
        nodeSuper1_4_2_1.contentType = XQNodeContentTypeSub;
        nodeSuper1_4_2_1.depth = 3;
        nodeSuper1_4_2_1.title = @"nodeSuper1_4_2_1";
        nodeSuper1_4_2_1.imagePath = @"profile_ic_male_normal";
        [nodeSuper1_4_2.subItems addObject:nodeSuper1_4_2_1];
        
        //--------2--------
        
        XQNode *nodeSuper2 = [[XQNode alloc] init];
        nodeSuper2.depth = 0;
        nodeSuper2.contentType = XQNodeContentTypeSuper;
        nodeSuper2.title = @"Super2";
        [_data addObject:nodeSuper2];
        
        XQNode *nodesub2_1 = [[XQNode alloc] init];
        nodesub2_1.contentType = XQNodeContentTypeSub;
        nodesub2_1.depth = 1;
        nodesub2_1.title = @"nodesub2_1";
        [nodeSuper2.subItems addObject:nodesub2_1];
        
        XQNode *nodesub2_2 = [[XQNode alloc] init];
        nodesub2_2.contentType = XQNodeContentTypeSub;
        nodesub2_2.depth = 1;
        nodesub2_2.title = @"nodesub2_2";
        [nodeSuper2.subItems addObject:nodesub2_2];
        
        //--------3--------
        
        XQNode *nodeSuper3 = [[XQNode alloc] init];
        nodeSuper3.depth = 0;
        nodeSuper3.contentType = XQNodeContentTypeSuper;
        nodeSuper3.title = @"Super3";
        [_data addObject:nodeSuper3];
        
    }
    
    return _data;
}


@end
