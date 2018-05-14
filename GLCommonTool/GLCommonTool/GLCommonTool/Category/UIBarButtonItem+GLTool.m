//
//  UIBarButtonItem+GLTool.m
//  GLCommonTool
//
//  Created by gu on 2018/5/14.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "UIBarButtonItem+GLTool.h"

@implementation UIBarButtonItem (GLTool)

 - (void)setImage:(UIImage *)image
{
    //原图显示
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
