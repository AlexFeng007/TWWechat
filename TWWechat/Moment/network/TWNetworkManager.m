//
//  TWNetworkManager.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/15.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWNetworkManager.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, URLTYPE) {
    URLUserInfo,
    URLMonentInfo,
};

@implementation TWNetworkManager

+ (NSString *)getRequestUrlWithType:(URLTYPE)requestType {
    if (requestType == URLUserInfo) {
        return @"http://thoughtworks-ios.herokuapp.com/user/jsmith";
    }else if (requestType == URLMonentInfo) {
        return @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets";
    }else{
        return nil;
    }
}

+(void)get:(NSString *)url params:(NSDictionary *)params completion:(TWNetworkInterfaceBlock)completion
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

+ (BOOL)isNetWorkAvailable
{
    // 0:无网络 & 1:2G & 2:3G & 3:4G & 5:WIFI
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

+ (void)requestUserInfoWithFinishBlock:(TWNetworkInterfaceBlock)block
{
    [self get:[self getRequestUrlWithType:URLUserInfo] params:nil completion:block];
}

+ (void)requestMomentInfoWithFinishBlock:(TWNetworkInterfaceBlock)block
{
    [self get:[self getRequestUrlWithType:URLMonentInfo] params:nil completion:block];
}

@end
