//
//  TWTweetCell.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWTweetCell.h"
#import "TWTweetModel.h"

#import "Masonry.h"
#import "Macros.h"
#import "SDWebImage.h"
#import "UIView+Geometry.h"

CGFloat maxLimitHeight = 0;
CGFloat lineSpacing = 5;
CGFloat itemSpaceing = 10;

@interface TWTweetCell()
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *avartImageView;
@property (nonatomic, strong) UIButton *shrinkBtn;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *commentArray;

@property (nonatomic, strong) TWTweetModel *model;
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
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.shrinkBtn];
}

- (void)updateLayoutViews
{
    //content
    if([self.contentLabel.text length] > 0) {
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = lineSpacing;
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
        [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,[self.contentLabel.text length])];
        self.contentLabel.attributedText = attributedText;
        
        // 判断显示'全文'/'收起'
        if(self.model.isFullText) {
            self.contentLabel.numberOfLines = 0;
            self.shrinkBtn.selected = self.model.isFullText;
            self.shrinkBtn.hidden = NO;
        }else{
            self.contentLabel.numberOfLines = 3;
            self.shrinkBtn.hidden = NO;
            self.shrinkBtn.selected = self.model.isFullText;
        }
        CGSize resultSize = [self.contentLabel sizeThatFits:CGSizeMake(kContentMaxWidth, MAXFLOAT)];
        CGFloat labelHeight = resultSize.height;
        self.contentLabel.frame = CGRectMake(self.nickName.left, self.nickName.bottom + itemSpaceing, resultSize.width, labelHeight);
        self.shrinkBtn.frame = CGRectMake(self.nickName.left, self.contentLabel.bottom + itemSpaceing, 40, 20);
    }
    
    
    if ([self.contentLabel.text length] > 0 && [self.contentLabel.text length] < 100) {
        self.contentLabel.numberOfLines = 0;
        self.shrinkBtn.hidden = YES;
    }
    
    //最终缓存行高 (暂时以contentLabel为基准)
    if (self.shrinkBtn.isHidden) {
        self.model.rowHeight = self.contentLabel.bottom + 15;
    }else{
        self.model.rowHeight = self.shrinkBtn.bottom + 15;
    }
}

#pragma mark: public method
- (void)configWithModel:(TWTweetModel *)model
{
    self.model = model;
    self.nickName.text = model.authorModel.nick;
    self.contentLabel.text = model.content;
    self.imageArray = model.imageList.mutableCopy;
    self.commentArray = model.commentArray.mutableCopy;
    
    [self.avartImageView sd_setImageWithURL:[NSURL URLWithString:model.authorModel.avatar] placeholderImage:[UIImage imageNamed:@"user_avatar_image"]];
    [self updateLayoutViews];
}

#pragma mark: lazy
- (UIImageView *)avartImageView
{
    if (!_avartImageView) {
        _avartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
        _avartImageView.layer.cornerRadius = 6;
        _avartImageView.clipsToBounds = YES;
    }
    return _avartImageView;
}

- (UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(self.avartImageView.right + 10, 15, 120, 20)];
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

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

#pragma mark: Actions
- (void)shrinkClicked:(UIButton *)sender
{
    sender.selected = !sender.selected; //反选
    self.model.isFullText = !self.model.isFullText;
    
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
