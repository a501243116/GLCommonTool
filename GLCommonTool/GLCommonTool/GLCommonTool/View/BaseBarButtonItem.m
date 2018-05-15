//
//  BaseBarButtonItem.m
//  GLCommonTool
//
//  Created by gu on 2018/5/15.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "BaseBarButtonItem.h"

@implementation BaseBarButtonItem

- (void)setImage:(UIImage *)image
{
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
