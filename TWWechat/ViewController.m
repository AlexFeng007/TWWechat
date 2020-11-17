//
//  ViewController.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) UIButton *showMomentBtn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    [self.view addSubview:self.showMomentBtn];
    [self.showMomentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(36.f);
    }];
}

#pragma mark: Actions
- (void)showMoment
{
    UIViewController *momentVC = [[NSClassFromString(@"TWMomentViewController") alloc] init];
    [self.navigationController pushViewController:momentVC animated:YES];
}

#pragma mark: lazy
- (UIButton *)showMomentBtn
{
    if (!_showMomentBtn) {
        _showMomentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showMomentBtn.frame = CGRectMake(0, 0, 160, 80);
        _showMomentBtn.backgroundColor = [UIColor redColor];
        _showMomentBtn.titleLabel.textColor = [UIColor whiteColor];
        _showMomentBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _showMomentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_showMomentBtn setTitle:@"showMoment" forState:UIControlStateNormal];
        [_showMomentBtn addTarget:self action:@selector(showMoment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showMomentBtn;
}

@end
