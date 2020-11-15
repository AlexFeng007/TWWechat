//
//  TWTweetModel.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface TWTweetModel : NSObject
@property (nonatomic, strong) NSString *avartUrl;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *content;

//layout
@property (nonatomic, assign) BOOL isFullText; //default NO
@end
NS_ASSUME_NONNULL_END
