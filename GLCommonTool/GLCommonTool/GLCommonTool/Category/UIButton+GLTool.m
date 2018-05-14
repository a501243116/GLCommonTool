//
//  UIButton+GLTool.m
//  EasyToVote
//
//  Created by gu on 2016/11/9.
//  Copyright © 2016年 yp. All rights reserved.
//

#import "UIButton+GLTool.h"

@implementation UIButton (GLTool)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
