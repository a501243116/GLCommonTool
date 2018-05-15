//
//  TestItem.m
//  GLCommonTool
//
//  Created by gu on 2018/5/15.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "TestItem.h"

@implementation TestItem

- (void)setImage:(UIImage *)image
{
    //原图显示
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
