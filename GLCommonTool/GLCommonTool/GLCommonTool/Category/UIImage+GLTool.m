//
//  UIImage+GLTool.m
//  EasyToVote
//
//  Created by gu on 16/1/12.
//  Copyright © 2016年 yp. All rights reserved.
//

#import "UIImage+GLTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (GLTool)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - InterpolatedUIImage

+ (UIImage *)createQRImageWithQRStr:(NSString *)str withSize:(CGFloat) size
{
    return [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:str] topimg:nil withSize:CGSizeMake(size, size)];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image topimg:(UIImage *)topimg withSize:(CGSize) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
    CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scaleWidth;
    size_t height = CGRectGetHeight(extent) * scaleHeight;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scaleWidth, scaleHeight);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *qrImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    if(topimg)
    {
        UIGraphicsBeginImageContext(qrImage.size);
        
        //Draw image2
        [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
        
        //Draw image1
        float r=qrImage.size.width*100/240;
        [topimg drawInRect:CGRectMake((qrImage.size.width-r)/2, (qrImage.size.height-r)/2 ,r, r)];
        //     [topimg drawInRect:CGRectMake(101, 101 ,37, 37)];
        //        [topimg drawInRect:CGRectMake((qrImage.size.width-38)/2, (qrImage.size.height-38)/2 ,38, 38)];
        qrImage=UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return qrImage;
}

#pragma mark - QRCodeGenerator
+ (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}


+ (UIImage *)createBarCodeImageWithStr:(NSString *)str withSize:(CGSize)size
{
    return [self createNonInterpolatedUIImageFormCIImage:[self generateBarCodeImage:str] topimg:nil withSize:size];
}
+ (CIImage *)generateBarCodeImage:(NSString *)source
{
    // 注意生成条形码的编码方式
    NSData *data = [source dataUsingEncoding: NSASCIIStringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    // 设置生成的条形码的上，下，左，右的margins的值
    [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
    return filter.outputImage;
}

+ (UIImage *)fetchLunchImage
{
    CGSize winSize = [UIApplication sharedApplication].keyWindow.frame.size;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        if(CGSizeEqualToSize(CGSizeFromString(dict[@"UILaunchImageSize"]),winSize))
        {
            return [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return nil;
}

/** 将图片旋转弧度radians */
//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 将图片旋转角度degrees */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    return [self imageRotatedByRadians:kDegreesToRadian(degrees)];
}

- (UIImage *)toGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;

}

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (UIImage*)getVideoPreViewImage:(NSURL *)videoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}

- (NSString *)qrimageToStr
{
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    UIImage *image = [self imageCompressForWidth:640];
    NSArray<CIFeature *> *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    __block NSString *message = nil;
    [features enumerateObjectsUsingBlock:^(CIFeature * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CIQRCodeFeature class]]) {
            message = [(CIQRCodeFeature *)obj messageString];
            *stop=YES;
        }
    }];
    return message;
}

- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    NSInteger targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
