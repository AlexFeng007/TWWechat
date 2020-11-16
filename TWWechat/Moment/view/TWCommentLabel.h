//
//  TWCommentLabel.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/16.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TWMomentCommentItemModel;
@interface TWCommentLabel : UIView
- (void)configCommnetWithModel:(TWMomentCommentItemModel *)model;
@end

NS_ASSUME_NONNULL_END
