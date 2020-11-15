//
//  TWMomentHeaderView.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TWUserModel;
@interface TWMomentHeaderView : UIView
- (void)updateUserInfoWith:(TWUserModel *)userModel;
@end

NS_ASSUME_NONNULL_END
