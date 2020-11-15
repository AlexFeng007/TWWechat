//
//  TWTweetModel.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/*TWTweetModel*/
@class TWMomentSenderModel;
@class TWMomentCommentItemModel;
@interface TWTweetModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray *imageList;
@property (nonatomic, copy) NSArray <TWMomentCommentItemModel *> *commentArray;
@property (nonatomic, strong) TWMomentSenderModel *authorModel;


//method
- (void)calculateContentWords;
//layout views properties
@property (nonatomic, assign) BOOL isFullText; //default NO
@property (nonatomic, assign) CGFloat rowHeight;
@end

/*TWMomentSenderModel*/
@interface TWMomentSenderModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *avatar;
@end

/*TWMomentCommentItemModel*/
@interface TWMomentCommentItemModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TWMomentSenderModel *sender;
@end

/*TWMomentImageModel*/
@interface TWMomentImageModel : NSObject
@property (nonatomic, copy) NSString *imageUrl;
@end
NS_ASSUME_NONNULL_END
