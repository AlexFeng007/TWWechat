//
//  TWNetworkManager.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/15.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TWNetworkInterfaceBlock)(id data, NSError *error);

@interface TWNetworkManager : NSObject
/**
* 获取当前Userinfo
*/
+ (void)requestUserInfoWithFinishBlock:(TWNetworkInterfaceBlock)block;

/**
* 获取当前MomentInfo
*/
+ (void)requestMomentInfoWithFinishBlock:(TWNetworkInterfaceBlock)block;

/**
* 获取当前网络是否可用
*/
+ (BOOL)isNetWorkAvailable;

@end

