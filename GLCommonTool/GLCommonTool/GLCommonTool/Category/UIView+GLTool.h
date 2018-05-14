//
//  UIView+GLTool.h
//  EasyToVote
//
//  Created by gu on 16/1/4.
//  Copyright © 2016年 yp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GLTool)


@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;
- (UIViewController*) getViewController;//得到当前view所在控制器

//描边
- (void)strokeViewHeader:(BOOL)header footer:(BOOL)footer;
- (void)strokeViewRatio:(NSInteger)ratio header:(BOOL)header footer:(BOOL)footer;

- (UIImage *)screenshot:(BOOL)saveToLocal;//把view画成image
- (UIImage *)screenshotSize:(CGSize)size saveToLocal:(BOOL)saveToLocal error:(void(^)(NSString *error))saveError;//指定大小截图

/**
 截图

 @param size 截图大小
 @param area 截图指定区域
 @param scale 缩放比例
 @param saveToLocal 是否保存本地
 @param saveError error
 @return UIImage
 */
- (UIImage *)screenshotSize:(CGSize)size area:(CGRect)area scale:(NSInteger)scale saveToLocal:(BOOL)saveToLocal error:(void(^)(NSString *error))saveError;
- (UIView*)duplicate;//序列化view
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;//虚线 水平方向
- (void)drawDashLineWithVerticalLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;//虚线 竖直方向
- (void)drawDashBorderLineColor:(UIColor *)lineColor cornerRadius:(CGFloat)radius;//虚线边框
@end
