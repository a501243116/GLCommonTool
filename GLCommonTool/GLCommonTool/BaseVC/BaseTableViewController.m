//
//  GLBaseTableViewController.m
//  GLCommonTool
//
//  Created by gu on 2018/5/10.
//  Copyright © 2018年 GL. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.heightForRow = 44;
    self.heightForFooter = 0.01;
    self.heightForHeader = 0.01;
    self.isGrop = NO;
}

- (void)setHeightForRow:(CGFloat)heightForRow
{
    _heightForRow = heightForRow;
    self.tableView.estimatedRowHeight = 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isGrop) {
        return [_tableViewDataArr[section] count];
    }
    return _tableViewDataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isGrop) {
        return _tableViewDataArr.count;
    }else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _heightForFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _heightForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _heightForRow;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, _heightForHeader)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, _heightForHeader)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGPoint origin = textField.frame.origin;
//    CGPoint point = [textField.superview convertPoint:origin toView:self.tableView];
//    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGPoint offset = self.tableView.contentOffset;
//    // Adjust the below value as you need
//    offset.y = (point.y - navBarHeight-40);
//    [self.tableView setContentOffset:offset animated:YES];
//}


//- (UIView *)getTabeleFooterView:(NSString *)describe imageName:(NSString *)imageName
//{
//    NSLog(@"%f------%f",self.tableView.contentSize.height,self.tableView.height);
//    UIView *footerView = self.tableView.tableFooterView;
//    if (footerView == nil || footerView.tag != 3290483) {
//        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0)];
//        footerView.tag = 3290483;
//        footerView.backgroundColor = [UIColor whiteColor];
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 84)];
//        imageView.image = [UIImage imageNamed:imageName];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [bgView addSubview:imageView];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 10, footerView.width, 20)];
//        label.tag = 3290482;
//        label.text = describe;
//        label.font = YPFontSize_m;
//        label.textColor = YPLightGrayColor;
//        label.textAlignment = NSTextAlignmentCenter;
//        [bgView addSubview:label];
//        bgView.height = label.bottom + 10;
//        if (self.tableView.height - self.tableView.contentSize.height > bgView.height) {
//            footerView.height = self.tableView.height - self.tableView.contentSize.height;
//        }else if (self.tableView.height < self.tableView.contentSize.height)
//        {
//            footerView.height = self.tableView.height;
//        }else
//            footerView.height = bgView.height;
//        [footerView addSubview:bgView];
//        bgView.center = CGPointMake(CGRectGetMidX(footerView.frame), CGRectGetMidY(footerView.frame));
//    }else
//    {
//        UILabel *label = [footerView viewWithTag:3290482];
//        label.text = describe;
//    }
//    return footerView;
//}
//
//- (void)getTabeleFooterView:(NSString *)describe count:(NSInteger)count
//{
//    [self getTabeleFooterView:describe imageName:@"NoDynamic" count:count];
//}
//
//- (void)getTabeleFooterView:(NSString *)describe imageName:(NSString *)imageName count:(NSInteger)count
//{
//    if (count == 0) {
//        self.tableView.tableFooterView = [self getTabeleFooterView:describe imageName:imageName];
//    }else
//    {
//        [self.tableView.tableFooterView removeFromSuperview];;
//        self.tableView.tableFooterView = nil;
//    }
//    
//}

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
