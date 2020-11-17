//
//  TWMomentViewController+Appearance.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/17.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWMomentViewController+Appearance.h"

@implementation TWMomentViewController (Appearance)

- (void)setupNav
{
    self.title = @"moment";
    UINavigationController *nav = self.navigationController;
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]};
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_image"] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.translucent = NO;
}

@end
