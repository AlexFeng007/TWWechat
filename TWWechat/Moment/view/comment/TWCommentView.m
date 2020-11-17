//
//  TWCommentView.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/16.
//  Copyright © 2020 YaphetS. All rights reserved.
//
#import "Macros.h"
#import "TWCommentView.h"
#import "UIView+Geometry.h"
#import "TWTweetModel.h"
#import "MJExtension.h"
#import "TWCommentLabel.h"

@interface TWCommentView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray<TWMomentCommentItemModel *> *commentModelArray;
@end

@implementation TWCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)removeAllSubViews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)loadCommentWith:(NSMutableArray *)commentArray
{
    
    [self removeAllSubViews];
    [self.commentModelArray removeAllObjects];
    
    if (commentArray.count == 0) {
        self.size = CGSizeZero;
        return ;
    }
    
    for (id sampleModel in commentArray) {
        TWMomentCommentItemModel *model = [TWMomentCommentItemModel mj_objectWithKeyValues:sampleModel];
        [self.commentModelArray addObject:model];
    }
    
    self.commentArray = commentArray;
    
    CGFloat itemHeight = 0;
    CGFloat startX = 0;
    CGFloat startY = 5;
    
    for (int i = 0; i < self.commentModelArray.count; i++) {
        TWCommentLabel *label = [[TWCommentLabel alloc] init];
        [label configCommnetWithModel:[self.commentModelArray objectAtIndex:i]];
        label.frame = CGRectMake(startX, startY, kContentMaxWidth, kCommentItemHeight);
        [self addSubview:label];
        startY = startY + kCommentItemHeight + kCommentItemSpace;
        itemHeight = label.bottom + kCommentItemSpace;
    }
    
    // 计算 CommentView 的总size
    self.size = CGSizeMake(kContentMaxWidth, itemHeight);
    
    // 计算总size后，插入bgview至视图底层
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    self.bgView.image = [[UIImage imageNamed:@"comment_bg_image"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    [self insertSubview:self.bgView atIndex:0];
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

- (NSMutableArray<TWMomentCommentItemModel *> *)commentModelArray
{
    if (!_commentModelArray) {
        _commentModelArray = [NSMutableArray new];
    }
    
    return _commentModelArray;
}

@end
