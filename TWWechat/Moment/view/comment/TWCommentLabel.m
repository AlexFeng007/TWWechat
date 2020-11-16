//
//  TWCommentLabel.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/16.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWCommentLabel.h"
#import "TWTweetModel.h"
#import "MLLinkLabel.h"
#import "Macros.h"
#import "UIView+Geometry.h"

MLLinkLabel *kMLLinkLabel()
{
    MLLinkLabel *_linkLabel = [MLLinkLabel new];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _linkLabel.textColor = [UIColor blackColor];
    _linkLabel.font = [UIFont systemFontOfSize:14.0];
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0]};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0],NSBackgroundColorAttributeName:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]};
    _linkLabel.activeLinkToNilDelay = 0.3;
    return _linkLabel;
}

NSMutableAttributedString *kMLLinkLabelAttributedText(id object)
{
    NSMutableAttributedString *attributedText = nil;
    if ([object isKindOfClass:[TWMomentCommentItemModel class]])
    {
        TWMomentCommentItemModel *comment = (TWMomentCommentItemModel *)object;
        NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.sender.nick,comment.content];
        attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],NSLinkAttributeName:comment.sender.nick}
                                range:[likeString rangeOfString:comment.sender.nick]];
    }
    return attributedText;
}


@interface TWCommentLabel ()

MLLinkLabel *kMLLinkLabel();
NSMutableAttributedString *kMLLinkLabelAttributedText(id object);

@property (nonatomic, retain) MLLinkLabel *linkLabel;
@property (nonatomic, strong) TWMomentCommentItemModel *commentModel;

@end

@implementation TWCommentLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    _linkLabel = kMLLinkLabel();
    [self addSubview:_linkLabel];
}

- (void)configCommnetWithModel:(TWMomentCommentItemModel *)model
{
    self.commentModel = model;
    _linkLabel.attributedText = kMLLinkLabelAttributedText(model);
    CGSize itemSize = [_linkLabel preferredSizeWithMaxWidth:kContentMaxWidth];
    _linkLabel.frame = CGRectMake(5, 3, itemSize.width, itemSize.height);
    self.height = itemSize.height +5;
}
@end
