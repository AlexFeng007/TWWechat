//
//  TWImageListView.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/16.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "Macros.h"
#import "TWImageListView.h"
#import "TWImageView.h"
#import "TWTweetModel.h"
#import "UIView+Geometry.h"
#import "MJExtension.h"
#import "SDWebImage.h"

@interface TWImageListView ()
@property (nonatomic, strong) NSMutableArray *imageListArray;
@property (nonatomic, strong) NSMutableArray<TWMomentImageModel *> *imageUrlArray;
@end

@implementation TWImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //Todo: Set border?
    }
    return self;
}

- (void)removeAllSubViews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)loadImagesWith:(NSMutableArray *)imageArray
{
    [self removeAllSubViews]; // 清理重用views
    [self.imageUrlArray removeAllObjects];
    
    if (imageArray.count == 0) {
        self.size = CGSizeZero;
        return ;
    }
    
    for (id sampleModel in imageArray) {
        TWMomentImageModel *model = [TWMomentImageModel mj_objectWithKeyValues:sampleModel];
        [self.imageUrlArray addObject:model];
    }
    
    self.imageListArray = imageArray;
    CGFloat itemHeight = 0;
    
    for (NSInteger i = 0; i < self.imageUrlArray.count; i++) {
        TWImageView *imageView = [[TWImageView alloc] init];
        imageView.tag = 10000+i;
        
        NSInteger rowNum = i / 3;
        NSInteger colNum = i % 3;
        
        if(imageArray.count == 4) {
            rowNum = i / 2;
            colNum = i % 2;
        }
        
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        if (imageArray.count == 1) {
            CGSize singleSize = CGSizeMake(100, 120); //获取原尺寸做放缩处理
            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
        }
        
        
        TWMomentImageModel *model = [self.imageUrlArray objectAtIndex:0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"user_avatar_image"]];
        imageView.hidden = NO;
        imageView.frame = frame;
        [self addSubview:imageView];
        itemHeight = imageView.bottom;
    }
    
    // 计算 ImageListView 总size
    self.size = CGSizeMake(kContentMaxWidth, itemHeight);
}

#pragma mark: lazy
- (NSMutableArray *)imageListArray
{
    if (!_imageListArray) {
        _imageListArray = [NSMutableArray new];
    }
    
    return _imageListArray;
}

- (NSMutableArray<TWMomentImageModel *> *)imageUrlArray
{
    if (!_imageUrlArray) {
        _imageUrlArray = [NSMutableArray new];
    }
    
    return _imageUrlArray;
}

@end
