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
@property (nonatomic, strong) UILabel *contentLabel;
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
    [self.contentView addSubview:self.avartImageView];
    [self.contentView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avartImageView.mas_top);
        make.left.mas_equalTo(self.avartImageView.mas_right).offset(10.f);
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickName.mas_left);
        make.top.mas_equalTo(self.nickName.mas_bottom).offset(10.f);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.f);
    }];
    
    [self.contentView addSubview:self.shrinkBtn];
    [self.shrinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickName.mas_left);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark: public method
- (void)setContentWith:(TWTweetModel *)model
{
    if (!model) {
        return ;
    }
    
}

- (void)setContentTitle:(NSString *)content
{
    self.contentLabel.text = content;
    self.shrinkBtn.hidden = YES;
    
    //判断显示 全文/收起
    if ([content length]) {
        CGSize resultSize = [self.contentLabel sizeThatFits:CGSizeMake(kContentMaxWidth, MAXFLOAT)];
        CGFloat labelHeight = resultSize.height;
        if (labelHeight > kContentMaxHeight) {
            self.contentLabel.backgroundColor = [UIColor redColor];
            self.shrinkBtn.hidden = NO;
            if (self.isFullText) {
               
                
            }else{
                //收缩全文
                [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.nickName.mas_bottom).offset(10.f);
                    make.left.mas_equalTo(self.nickName.mas_left);
                    make.right.mas_equalTo(self.contentView.mas_right).offset(-10.f);
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.f);
                }];
                [self.shrinkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.nickName.mas_left);
                    make.top.mas_equalTo(self.nickName.mas_bottom).offset(80.f);
                    make.width.mas_equalTo(40);
                    make.height.mas_equalTo(20);
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.f);
                }];
            }
        }else{
            self.contentLabel.backgroundColor = [UIColor greenColor];
            self.shrinkBtn.hidden = YES;
            [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.mas_equalTo(self.nickName.mas_left);
                   make.top.mas_equalTo(self.nickName.mas_bottom).offset(10.f);
                   make.right.mas_equalTo(self.contentView.mas_right).offset(-10.f);
                   make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.f);
            }];
            [self.shrinkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.nickName.mas_left);
                make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(20);
            }];
        }
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
        _nickName.textColor = kNickNameColor;
        _nickName.font = [UIFont systemFontOfSize:17.f];
        _nickName.textAlignment = NSTextAlignmentLeft;
    }
    
    return _nickName;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:15.f];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    }
    
    return _contentLabel;
}

- (UIButton *)shrinkBtn
{
    if (!_shrinkBtn) {
        _shrinkBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _shrinkBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_shrinkBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_shrinkBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_shrinkBtn setTitleColor:kButtonTextColor forState:UIControlStateNormal];
        [_shrinkBtn addTarget:self action:@selector(shrinkClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_shrinkBtn sizeToFit];
    }
    
    return _shrinkBtn;
}

#pragma mark: Actions
- (void)shrinkClicked:(UIButton *)sender
{
    sender.selected = !sender.selected; //反选
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickShinkWithType:withCell:)]) {
        [self.delegate didClickShinkWithType:sender.selected withCell:self];
    }
}

#pragma mark: cellIdentifier

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

@end
