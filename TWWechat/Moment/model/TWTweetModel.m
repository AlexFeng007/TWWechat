//
//  TWTweetModel.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWTweetModel.h"
#import "MJExtension.h"
/*TWTweetModel*/
@implementation TWTweetModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"content":@"content",
        @"imageList":@"images",
        @"authorModel":@"sender",
        @"commentArray":@"comments",
    };
}
@end

/*TWMomentSenderModel*/
@implementation TWMomentSenderModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"username":@"username",
        @"nick":@"nick",
        @"avatar":@"avatar",
    };
}
@end

/*TWMomentCommentItemModel*/
@implementation TWMomentCommentItemModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"content":@"content",
        @"sender":@"sender",
    };
}
@end

/*TWMomentImageModel*/
@implementation TWMomentImageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"imageUrl":@"url",
    };
}
@end


