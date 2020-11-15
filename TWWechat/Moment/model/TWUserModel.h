//
//  TWUserModel.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/15.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TWUserModel : NSObject
@property (nonatomic, copy) NSString *profileImage;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *username;
@end
NS_ASSUME_NONNULL_END
