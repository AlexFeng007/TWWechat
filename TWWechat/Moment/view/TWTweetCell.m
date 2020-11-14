//
//  TWTweetCell.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWTweetCell.h"
#import "Masonry.h"
#import "Macros.h"

@interface TWTweetCell()

@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UIImageView *avartImageView;
@property (nonatomic, strong) UILabel *momentLabel;
@property (nonatomic, strong) UIButton *shrinkBtn;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation TWTweetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

#pragma mark: private method
- (void)setupViews
{
    [self addSubview:self.avartImageView];
    [self addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avartImageView.mas_top);
        make.left.mas_equalTo(self.avartImageView.mas_right).offset(10.f);
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(20.f);
    }];
}

#pragma mark: public method
- (void)setContentWith:(TWTweetModel *)model
{
    if (!model) {
        return ;
    }
    
    
}

#pragma mark: lazy
- (UIImageView *)avartImageView
{
    if (!_avartImageView) {
        _avartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
        _avartImageView.image = [UIImage imageNamed:@"user_avatar_image"];
        _avartImageView.layer.cornerRadius = 6;
        _avartImageView.clipsToBounds = YES;
    }
    return _avartImageView;
}
- (UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        _nickName.text = @"YaphetS";
        _nickName.textColor = kTextColor;
        _nickName.font = [UIFont systemFontOfSize:17.f];
        _nickName.textAlignment = NSTextAlignmentLeft;
    }
    
    return _nickName;
}

#pragma mark: cellIdentifier

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

@end
