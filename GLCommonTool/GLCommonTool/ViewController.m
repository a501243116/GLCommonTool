//
//  ViewController.m
//  GLCommonTool
//
//  Created by gu on 2018/5/10.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "ViewController.h"
#import "TestItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myoccasion_add"] style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.leftBarButtonItem = testItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
