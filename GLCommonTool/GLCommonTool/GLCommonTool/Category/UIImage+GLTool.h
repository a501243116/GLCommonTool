//
//  UIImage+GLTool.h
//  EasyToVote
//
//  Created by gu on 16/1/12.
//  Copyright © 2016年 yp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GLTool)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)createQRImageWithQRStr:(NSString *)str withSize:(CGFloat) size;//二维码
+ (UIImage *)fetchLunchImage;//得到启动图
+ (UIImage *)createBarCodeImageWithStr:(NSString *)str withSize:(CGSize)size;//条形码
//获取视频的第一帧
+ (UIImage*)getVideoPreViewImage:(NSURL *)videoPath;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;//得到正确方向的image
-(UIImage *)toGrayImage;//图片去色置灰
/**
 识别图片二维码

 @return 二维码字符串
 */
- (NSString *)qrimageToStr;

/**
 图片压缩

 @param defineWidth 压缩宽度 高自适应
 @return
 */
- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth;

@end
