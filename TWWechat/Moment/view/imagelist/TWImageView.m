//
//  TWImageView.m
//  TWWechat
//
//  Created by YaphetS on 2020/11/16.
//  Copyright © 2020 YaphetS. All rights reserved.
//

#import "TWImageView.h"

@implementation TWImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
               
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [self addGestureRecognizer:tapGes];
    }
    
    return self;
}

- (void)tapImage:(UIGestureRecognizer *)gesture
{
    NSLog(@"tap the image");
}

@end
