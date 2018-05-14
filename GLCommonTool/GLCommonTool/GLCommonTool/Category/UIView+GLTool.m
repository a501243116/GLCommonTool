//
//  UIView+GLTool.m
//  EasyToVote
//
//  Created by gu on 16/1/4.
//  Copyright © 2016年 yp. All rights reserved.
//

#import "UIView+GLTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BaseConfig.h"

@implementation UIView (GLTool)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (UIViewController*)getViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

static CGFloat height = 0.5;
//头尾描边
- (void)strokeViewHeader:(BOOL)header footer:(BOOL)footer
{
    //头部描边
    if (header) {
        UIView *headerStroke = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
        headerStroke.backgroundColor = UIColorFromRGB(0xe8eae9);
        headerStroke.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:headerStroke];
    }
    //尾部描边
    if (footer) {
        UIView *footerStroke = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - height, self.bounds.size.width, height)];
        footerStroke.backgroundColor = UIColorFromRGB(0xe8eae9);
        footerStroke.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:footerStroke];
    }
}

//按比例增加描边
- (void)strokeViewRatio:(NSInteger)ratio header:(BOOL)header footer:(BOOL)footer
{
    for (int i=1; i<=ratio; i++) {
        CGFloat y = self.height / ratio * i;
        UIView *headerStroke = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, height)];
        headerStroke.backgroundColor = UIColorFromRGB(0xe8eae9);
        headerStroke.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:headerStroke];
    }
    [self strokeViewHeader:header footer:footer];
}

- (UIImage *)screenshot:(BOOL)saveToLocal
{
    return [self screenshotSize:self.frame.size saveToLocal:saveToLocal error:nil];
}

- (UIImage *)screenshotSize:(CGSize)size saveToLocal:(BOOL)saveToLocal error:(void(^)(NSString *error))saveError
{
    return [self screenshotSize:size area:CGRectZero scale:2 saveToLocal:saveToLocal error:nil];
}

- (UIImage *)screenshotSize:(CGSize)size area:(CGRect)area scale:(NSInteger)scale saveToLocal:(BOOL)saveToLocal error:(void(^)(NSString *error))saveError
{
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewScreenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (area.origin.x > 0 || area.origin.y > 0) {
        area = CGRectMake(area.origin.x * scale, area.origin.y * scale, area.size.width * scale, area.size.height * scale);
        CGImageRef imageRef = viewScreenshotImage.CGImage;
        CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, area);
        viewScreenshotImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    }
    if (saveToLocal)
    {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:viewScreenshotImage.CGImage orientation:(ALAssetOrientation)viewScreenshotImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
            [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                if (saveError) {
                    saveError(nil);
                }
                
            } failureBlock:^(NSError *error) {
                if (saveError) {
                    saveError(error.userInfo[@"NSLocalizedFailureReason"]);
                }
            }];
        }];
        //        UIImageWriteToSavedPhotosAlbum(viewScreenshotImage,nil,nil,nil);
    }
    return viewScreenshotImage;
}

- (UIView *)duplicate
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    self.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawDashLineWithVerticalLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawDashBorderLineColor:(UIColor *)lineColor cornerRadius:(CGFloat)radius
{
    //虚线
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect frame = self.bounds;
    CGFloat cornerRadius = radius;
    //drawing a border around a view
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    border.path = path;
    CGPathRelease(path);
    border.frame = self.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@2, @2];
    border.cornerRadius = 2;
    border.masksToBounds = YES;
    [self.layer addSublayer:border];
}

@end
