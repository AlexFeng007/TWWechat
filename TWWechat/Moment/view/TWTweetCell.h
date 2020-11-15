//
//  TWTweetCell.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TWTweetCell;
@protocol TWTweetCellDelegate<NSObject>
@required
- (void)didClickShinkWithType:(BOOL)isShow withCell:(TWTweetCell *)cell;
- (void)didClickImageWithIndex:(NSInteger)imageIndex;
@end

@class TWTweetModel;
@interface TWTweetCell : UITableViewCell
@property (nonatomic, weak) id<TWTweetCellDelegate> delegate;

+ (NSString *)cellIdentifier;
- (void)configWithModel:(TWTweetModel *)model;

@end

NS_ASSUME_NONNULL_END
