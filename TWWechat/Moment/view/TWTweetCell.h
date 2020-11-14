//
//  TWTweetCell.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TWTweetModel;
@interface TWTweetCell : UITableViewCell
+ (NSString *)cellIdentifier;
- (void)setContentWith:(TWTweetModel *)model;
@end

NS_ASSUME_NONNULL_END
