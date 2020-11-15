//
//  UIView+Geometry.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/15.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Geometry)
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
