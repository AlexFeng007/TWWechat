//
//  TWMomentViewController.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentViewController.h"
#import "TWMomentHeaderView.h"
#import "TWTweetCell.h"

#import "Masonry.h"
#import "Macros.h"

@interface TWMomentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TWMomentHeaderView *tableHeaderView;
@end

@implementation TWMomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupViews];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
}

#pragma mark: Delegate && Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TWTweetCell cellIdentifier]];
    if (!cell) {
        cell = [[TWTweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TWTweetCell cellIdentifier]];
    }
    return cell;
}

#pragma mark: lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (TWMomentHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[TWMomentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.655)];
    }
    return _tableHeaderView;
}

#pragma mark: dealloc
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
