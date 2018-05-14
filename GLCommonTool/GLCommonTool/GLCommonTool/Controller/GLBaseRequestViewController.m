//
//  UIViewController+Request.m
//  GLCommonTool
//
//  Created by gu on 2018/5/11.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "GLBaseRequestViewController.h"
#import <AFNetworking/AFNetworking.h>

@implementation GLBaseRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic success:(void(^)(id sta))success error:(void(^)(id error))errorInfo
{
    [self startRequest:str paramsDic:paramsDic isShowView:YES isShowAlter:YES success:success error:errorInfo];
}

- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic isShowView:(BOOL)isShowView success:(void(^)(id sta))success error:(void(^)(id error))errorInfo
{
    [self startRequest:str paramsDic:paramsDic isShowView:isShowView isShowAlter:YES success:success error:errorInfo];
}

- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic isShowView:(BOOL)isShowView isShowAlter:(BOOL)isShowAlter success:(void(^)(id sta))success error:(void(^)(id error))errorInfo
{
    [self startRequest:str paramsDic:paramsDic isShowView:isShowView isShowAlter:isShowAlter timeOut:20 success:success error:errorInfo];
}

- (void)startRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic isShowView:(BOOL)isShowView isShowAlter:(BOOL)isShowAlter timeOut:(NSInteger)timeOut success:(void(^)(id sta))success error:(void(^)(id error))errorInfo
{
    if (isShowView) {
        if (!self.GLRequestHUD) {
            _GLRequestHUD = [[MBProgressHUD alloc] initWithView:self.view];
        }
        [_GLRequestHUD showAnimated:YES];
    }
    [_GLRequestHUD showAnimated:YES];
    self.GLHandleSuccess = success;
    self.GLHandleFailure = errorInfo;
    NSMutableDictionary *dic;
    if (paramsDic) {
        dic = [NSMutableDictionary dictionaryWithDictionary:paramsDic];
    }else
        dic = [NSMutableDictionary dictionary];
    if (self.GLBaseCommonDic) {
        [dic addEntriesFromDictionary:self.GLBaseCommonDic];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:timeOut];
    NSString *url = [NSString stringWithFormat:@"%@%@",self.GLBaseUrl,str];
    if ([str hasPrefix:@"http"]) {
        url = str;
    }
    NSLog(@"%@",dic);
    if (_GLIsGet) {
        [manager GET:url parameters:dic progress:nil success:self.GLAFNRequestSuccess failure:self.GLAFNRequestFailure];
    }else
        [manager POST:url parameters:dic progress:nil success:self.GLAFNRequestSuccess  failure:self.GLAFNRequestFailure];
}

- (void)uploadRequest:(NSString *)str paramsDic:(NSDictionary *)paramsDic image:(UIImage *)image success:(void(^)(id sta))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (!self.GLRequestHUD) {
        _GLRequestHUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    [_GLRequestHUD showAnimated:YES];
    NSMutableDictionary *dic;
    if (paramsDic) {
        dic = [NSMutableDictionary dictionaryWithDictionary:paramsDic];
    }else
        dic = [NSMutableDictionary dictionary];
    if (self.GLBaseCommonDic) {
        [dic addEntriesFromDictionary:self.GLBaseCommonDic];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",self.GLBaseUrl,str];
    if ([str hasPrefix:@"http"]) {
        url = str;
    }
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            NSData *data =  UIImageJPEGRepresentation(image, 1); //将拍下的图片转化成data
            [formData appendPartWithFileData:data name:self.GLUpdateName fileName:self.GLUpdateFileName mimeType:self.GLUpdateMimeType];
        }
        NSLog(@"%@",manager.requestSerializer.HTTPRequestHeaders);
    } progress:nil success:self.GLAFNRequestSuccess  failure:self.GLAFNRequestFailure];
}

@end
