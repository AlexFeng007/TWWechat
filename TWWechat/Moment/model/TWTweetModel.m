//
//  TWTweetModel.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWTweetModel.h"
#import "MJExtension.h"
@implementation TWTweetModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"avartUrl":@"serverAvaatr",
    };
}

@end
