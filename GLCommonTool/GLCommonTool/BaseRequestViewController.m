//
//  BaseRequestViewController.m
//  GLCommonTool
//
//  Created by gu on 2018/5/11.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "BaseRequestViewController.h"

@interface BaseRequestViewController ()

@end

@implementation BaseRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configCommonRequest
{
    [self setGLAFNRequestSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    }];
    [self setGLAFNRequestFailure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
