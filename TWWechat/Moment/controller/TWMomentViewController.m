//
//  TWMomentViewController.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentViewController.h"
#import "TWMomentViewController+Appearance.h"
#import "TWNetworkManager.h"
#import "TWMomentHeaderView.h"
#import "TWTweetCell.h"

#import "Masonry.h"
#import "Macros.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#import "TWUserModel.h"
#import "TWTweetModel.h"

@interface TWMomentViewController () <UITableViewDelegate,UITableViewDataSource,TWTweetCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TWMomentHeaderView *tableHeaderView;

@property (nonatomic, strong) TWUserModel *userModel;
@property (nonatomic, strong) NSMutableArray *tweetArray;
@property (nonatomic, strong) NSMutableArray *tweetLoadArray;

@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger index;
@end

@implementation TWMomentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self initData];
    [self setupViews];
    [self initRefresh];
}

- (void)initData
{
    [self requestUserInfo];
    [self requestMomentInfo];
}

- (void)initRefresh
{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf resetPagesIndex];
        [weakSelf requestUserInfo];
        [weakSelf requestMomentInfo];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMomentInfoWithPageIndex:weakSelf.index];
    }];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)resetPagesIndex
{
    self.pages = 0;
    self.index = 0;
}

#pragma mark: Delegate && Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetLoadArray.count;
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
        [self.tableView reloadData];
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
        _tableHeaderView = [[TWMomentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 270)];
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

- (NSMutableArray *)tweetLoadArray
{
    if (!_tweetLoadArray) {
        _tweetLoadArray = [NSMutableArray new];
    }
    return _tweetLoadArray;
}

#pragma mark: dealloc
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

#pragma mark: Networking Request
- (void)requestUserInfo
{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TWNetworkManager requestUserInfoWithFinishBlock:^(id data, NSError *error) {
        if (error.code == 0) {
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                TWUserModel *model = [TWUserModel mj_objectWithKeyValues:data];
                if (model) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    weakSelf.userModel = model;
                    [weakSelf.tableHeaderView updateUserInfoWith:model];
                }
            }
        }
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)requestMomentInfo
{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [TWNetworkManager requestMomentInfoWithFinishBlock:^(id data, NSError *error) {
        if (error.code == 0) {
            [weakSelf.tweetArray removeAllObjects];
            NSArray *listArray = (NSArray *)data;
            for (id sampleModel in listArray) {
                TWTweetModel *model = [TWTweetModel mj_objectWithKeyValues:sampleModel];
                if (model.content) { // 未发言Content的过滤掉
                    [model calculateContentWords];
                    [weakSelf.tweetArray addObject:model];
                }
            }
            
            // 判断第一次是否显示footer
            if (weakSelf.tweetArray.count > 5) {
                [weakSelf.tableView.mj_footer setHidden:NO];
            }else{
                [weakSelf.tableView.mj_footer setHidden:YES];
            }
            
            if (weakSelf.tweetArray.count > 0) {
                weakSelf.pages = (weakSelf.tweetArray.count / 5) + 1;
                [weakSelf requestMomentInfoWithPageIndex:0]; //下拉刷新从第0页开始请求
            }
        }
    }];
}

- (void)requestMomentInfoWithPageIndex:(NSInteger)index
{
    if (index >= self.pages) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer setHidden:YES];
        return ;
    }

    [self.tweetLoadArray removeAllObjects];
    NSInteger showCount = (index + 1) * 5;
    
    if (showCount > self.tweetArray.count) {
        showCount = self.tweetArray.count;
        [self.tableView.mj_footer setHidden:YES];
    }
    
    for (int i = 0; i < showCount; i++) {
        TWTweetModel *model = [self.tweetArray objectAtIndex:i];
        [self.tweetLoadArray addObject:model];
    }
    
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
    self.index++;
}

@end
