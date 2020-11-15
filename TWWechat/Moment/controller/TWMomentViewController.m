//
//  TWMomentViewController.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentViewController.h"
#import "TWNetworkManager.h"
#import "TWMomentHeaderView.h"
#import "TWTweetCell.h"

#import "Masonry.h"
#import "Macros.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"

#import "TWUserModel.h"
#import "TWTweetModel.h"

@interface TWMomentViewController () <UITableViewDelegate,UITableViewDataSource,TWTweetCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TWMomentHeaderView *tableHeaderView;

@property (nonatomic, strong) TWUserModel *userModel;

// mock
@property (nonatomic, strong) NSMutableArray *mockTitleArray;
@end

@implementation TWMomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self initData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
}

#pragma mark: Delegate && Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mockTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:[TWTweetCell cellIdentifier]];
    if (!cell) {
        cell = [[TWTweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TWTweetCell cellIdentifier]];
    }
    cell.delegate = self;
    [cell setContentTitle:[self.mockTitleArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark: TWTweetCellDelegate
- (void)didClickShinkWithType:(BOOL)isShow withCell:(TWTweetCell *)cell
{
    if (isShow) {
        NSLog(@"show");
        cell.isFullText = YES;
    }else {
        NSLog(@"not show");
        cell.isFullText = NO;
    }
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        [UIView performWithoutAnimation:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)didClickImageWithIndex:(NSInteger)imageIndex
{
    //Todo: Show Image
}

#pragma mark: lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.separatorInset = UIEdgeInsetsZero;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark: Networking Request
- (void)requestUserInfo {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TWNetworkManager requestUserInfoWithFinishBlock:^(id data, NSError *error) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            TWUserModel *model = [TWUserModel mj_objectWithKeyValues:data];
            if (model) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                weakSelf.userModel = model;
                [weakSelf.tableHeaderView updateUserInfoWith:model];
            }
        }
    }];
}

#pragma mark: date mocks
- (NSMutableArray *)mockTitleArray
{
    if (!_mockTitleArray) {
        _mockTitleArray = [NSMutableArray new];
    }
    return _mockTitleArray;
}

- (void)initData{
    
    //网络请求
    [self requestUserInfo];
    
    self.mockTitleArray = @[@"先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度",@"先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度",@"先试试UILabel的自定义长度先试试UILabel的自定义长度",@"仰天大笑出门去，我辈岂是蓬蒿人，仰天大笑出门去，我辈岂是蓬蒿人，仰天大笑出门去，我辈岂是蓬蒿人",@"先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度",@"先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度,先试试UILabel的自定义长度",@"先试试UILabel的自定义长度先试试UILabel的自定义长度",@"仰天大笑出门去，我辈岂是蓬蒿人，仰天大笑出门去，我辈岂是蓬蒿人，仰天大笑出门去，我辈岂是蓬蒿人"].mutableCopy;
}

@end
