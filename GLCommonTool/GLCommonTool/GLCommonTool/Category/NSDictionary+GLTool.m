//
//  NSDictionary+GLTool.m
//  EasyToVote
//
//  Created by gu on 2017/6/23.
//  Copyright © 2017年 yp. All rights reserved.
//

#import "NSDictionary+GLTool.h"

@implementation NSDictionary (GLTool)

//字典转为Json字符串
- (NSString *)toJsonStr
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
