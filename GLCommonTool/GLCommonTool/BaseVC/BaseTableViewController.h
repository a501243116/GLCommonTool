//
//  GLBaseTableViewController.h
//  GLCommonTool
//
//  Created by gu on 2018/5/10.
//  Copyright © 2018年 GL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRequestViewController.h"

@interface BaseTableViewController : BaseRequestViewController

/**
 记得赋值！！！
 */
@property(nonatomic,strong)UITableView *tableView;
/**
 数据源 如果isGrop YES 则对应二维数组
 */
@property (nonatomic , strong) NSMutableArray *tableViewDataArr;
/**
 是否分组 默认NO
 */
@property (nonatomic , assign) BOOL isGrop;

/**
 cell高度 默认44
 */
@property (nonatomic , assign) CGFloat heightForRow;
/**
 组尾 默认0
 */
@property (nonatomic , assign) CGFloat heightForFooter;
/**
 组头 默认0
 */
@property (nonatomic , assign) CGFloat heightForHeader;

@end
