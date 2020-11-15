//
//  TWUserModel.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/15.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWUserModel.h"
#import "MJExtension.h"

@implementation TWUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"profileImage":@"profile-image",
        @"avatar":@"avatar",
        @"nick":@"nick",
        @"username":@"username",
    };
}
@end
