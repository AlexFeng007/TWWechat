//
//  TWMomentHeaderView.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentHeaderView.h"
#import "Masonry.h"

@interface TWMomentHeaderView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *avartView;
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
    [self addSubview:self.avartView];
    [self.avartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75.f);
        make.height.mas_equalTo(75.f);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
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
        _avartView.layer.borderWidth = 2;
        _avartView.layer.cornerRadius = 6;
        _avartView.clipsToBounds = YES;
        _avartView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    return _avartView;
}

@end
