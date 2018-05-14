//
//  UIViewController+Request.h
//  GLCommonTool
//
//  Created by gu on 2018/5/11.
//  Copyright © 2018年 GL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface GLBaseRequestViewController : UIViewController

/**
 自定义处理返回数据统一逻辑  这里是AFN请求返回结果
 */
@property (nonatomic,copy)void (^GLAFNRequestSuccess)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);

/**
 请求失败 自定义处理返回数据统一逻辑 这里是AFN请求返回结果
 */
@property (nonatomic,copy)void (^GLAFNRequestFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@property (nonatomic , copy) void (^GLHandleSuccess)(id sta);
@property (nonatomic , copy) void (^GLHandleFailure)(id error);

/**
 所有api的相同前缀
 */
@property (nonatomic , strong) NSString *GLBaseUrl;

/**
 所有请求都需要传的参数
 */
@property (nonatomic , strong) NSDictionary *GLBaseCommonDic;

//[formData appendPartWithFileData:data name:@"imgfile" fileName:@"1.jpg" mimeType:@"image/jpeg"]
/**
 分别对应上面注释的name(服务器上面的文件夹名字) fileName(后台说的是直接取的这个字段名的后缀名) mimeType
 */
@property (nonatomic , strong) NSString *GLUpdateName;
@property (nonatomic , strong) NSString *GLUpdateFileName;
@property (nonatomic , strong) NSString *GLUpdateMimeType;


/**
 默认Post请求 如果 GLIsGet == YES get请求
 */
@property (nonatomic , assign) BOOL GLIsGet;

/**
 菊花，可以自定义 请求结束必须调用
 [self.GLRequestHUD hideAnimated:YES];
 */
@property (nonatomic , strong) MBProgressHUD *GLRequestHUD;


- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic success:(void(^)(id sta))success error:(void(^)(id error))errorInfo;//默认错误直接弹出对话框，请求显示指示器
- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic isShowView:(BOOL)isShowView success:(void(^)(id sta))success error:(void(^)(id error))errorInfo;//默认错误直接弹出对话框，请求是否显示指示器
- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic isShowView:(BOOL)isShowView isShowAlter:(BOOL)isShowAlter timeOut:(NSInteger)timeOut success:(void(^)(id sta))success error:(void(^)(id error))errorInfo;//主要是为了设置请求时长
- (void)uploadRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic image:(UIImage *)image success:(void(^)(id sta))success failure:(void (^)(void))failure;//上传

@end
