//
//  Macros.h
//  TWWechat
//
//  Created by YaphetS on 2020/11/14.
//  Copyright © 2020 YaphetS. All rights reserved.
//
#ifndef Macros_h
#define Macros_h

// Screen Width
#define kScreenWidth         [UIScreen mainScreen].bounds.size.width
// Screen Height
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height
// Status Height
#define kStatusHeight        [[UIApplication sharedApplication] statusBarFrame].size.height
// NavBar Height
#define kNavHeight           self.navigationController.navigationBar.height
// NickName TextColor
#define kNickNameColor       [UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0]
// Button TextColor
#define kButtonTextColor     [UIColor colorWithRed:0.09 green:0.49 blue:0.99 alpha:1.0]

#endif /* Macros_h */