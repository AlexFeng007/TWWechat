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
@property (nonatomic, strong) NSMutableArray *tweetArray;
@end

@implementation TWMomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupViews];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark: Delegate && Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWTweetModel *model = [self.tweetArray objectAtIndex:indexPath.row];
    return model.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:[TWTweetCell cellIdentifier]];
    if (!cell)
    {
        cell = [[TWTweetCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:[TWTweetCell cellIdentifier]];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithModel:[self.tweetArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark: TWTweetCellDelegate
- (void)didClickShinkWithType:(BOOL)isShow withCell:(TWTweetCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TWTweetModel *model = [self.tweetArray objectAtIndex:indexPath.row];
    if (isShow) {
        model.isFullText = YES;
    }else{
        model.isFullText = NO;
    }
    
    if (indexPath) {
        [UIView performWithoutAnimation:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
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

- (NSMutableArray *)tweetArray
{
    if (!_tweetArray) {
        _tweetArray = [NSMutableArray new];
    }
    return _tweetArray;
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

- (void)requestMomentInfo{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [TWNetworkManager requestMomentInfoWithFinishBlock:^(id data, NSError *error) {
        if (error.code == 0) {
            NSArray *listArray = (NSArray *)data;
            for (id sampleModel in listArray) {
                TWTweetModel *model = [TWTweetModel mj_objectWithKeyValues:sampleModel];
                if (model.content) { // 未发言Content的过滤掉
                    [model calculateContentWords];
                    [weakSelf.tweetArray addObject:model];
                }
            }
            if (weakSelf.tweetArray.count > 0) {
                [weakSelf.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            }
        }
    }];
}

- (void)initData{
    //网络请求
    [self requestUserInfo];
    [self requestMomentInfo];
}

@end
