//
//  ViewController.m
//  XQMultistageTableView
//
//  Created by MacG on 17/2/4.
//  Copyright (c) 2017年 IT_XQ. All rights reserved.
//

#import "ViewController.h"
#import "BaseTypeViewController.h"
#import "DefaultTypeViewController.h"
#import "CustomTypeViewController.h"
#import "CustomTypeViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray<NSString *> *data;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"QMultistage";
    
    CustomTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[CustomTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _data[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        BaseTypeViewController * viewController = [BaseTypeViewController new];
        viewController.title = _data[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (indexPath.row == 1) {
        
        DefaultTypeViewController * viewController = [DefaultTypeViewController new];
        viewController.title = _data[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (indexPath.row == 2) {
        
        CustomTypeViewController * viewController = [CustomTypeViewController new];
        viewController.title = _data[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSMutableArray<NSString *> *)data
{
    if (!_data) {
        
        _data = [NSMutableArray array];
        
        [_data addObject:@"Base"];
        [_data addObject:@"Default"];
        [_data addObject:@"Custom"];
    }
    
    return _data;
}


@end
