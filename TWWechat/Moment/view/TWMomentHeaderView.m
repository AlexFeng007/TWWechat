//
//  TWMomentHeaderView.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentHeaderView.h"
#import "TWUserModel.h"
#import "Masonry.h"
#import "Macros.h"
#import "SDWebImage.h"

@interface TWMomentHeaderView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *avartView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@end

@implementation TWMomentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-40);
    }];
    
    [self addSubview:self.avartView];
    [self.avartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75.f);
        make.height.mas_equalTo(75.f);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.avartView.mas_left).offset(-20.f);
        make.centerY.mas_equalTo(self.avartView.mas_centerY).offset(-10.f);
    }];
}

- (void)updateUserInfoWith:(TWUserModel *)userModel
{
    if (!userModel) {return;}
    self.nickNameLabel.text = userModel.username;
    [self.avartView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:[UIImage imageNamed:@"user_avatar_image"]];
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:userModel.profileImage] placeholderImage:[UIImage imageNamed:@"moment_bg_image"]];
}

#pragma mark: lazy
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40)];
        _bgView.image = [UIImage imageNamed:@"moment_bg_image"];
    }
    return _bgView;
}

- (UIImageView *)avartView
{
    if (!_avartView) {
        _avartView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
        _avartView.image = [UIImage imageNamed:@"user_avatar_image"];
        _avartView.backgroundColor = kImageViewBGColor;
        _avartView.layer.borderWidth = 2;
        _avartView.layer.cornerRadius = 6;
        _avartView.clipsToBounds = YES;
        _avartView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _avartView;
}

- (UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.text = @"YaphetS";
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:17.f];
        _nickNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nickNameLabel;
}

@end
