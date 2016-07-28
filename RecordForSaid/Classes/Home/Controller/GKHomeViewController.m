//
//  GKHomeViewController.m
//  RecordForSaid
//
//  Created by 花菜ChrisCai on 2016/7/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "GKHomeViewController.h"
#import "GKCommonCell.h"
#import "GKRecordModel.h"
#import "GKBlockedBarButtonItem.h"
#import "GKAboutViewController.h"
@interface GKHomeViewController ()
@end

@implementation GKHomeViewController
#pragma mark -
#pragma mark - =============== 生命周期方法 ===============

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GKCommonCell class]) bundle:nil]forCellReuseIdentifier:@"GKCommonCell"];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [GKThemeTool setTheme];
  
    NSString * timeStr = [[NSDate new]gk_yyyyMMddTimeString];
    // 获取今天的日记 ,并倒序排序
    self.dataSource = [[[GKDatabaseManager sharedManager] selectObject:[GKRecordModel class] propertyName:@"createTime" type:GKDatabaseSelectRangOfString content:timeStr] reverseObjectEnumerator].allObjects.mutableCopy;
    [self.tableView reloadData];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.rowHeight = 70;
    self.tableView.contentInsetTop = GKCommonMargin + GKNavBarHeight;
    self.tableView.contentInsetBottom = GKCommonMargin + GKTabBarHeight;
}
- (void)setupNav {
    GKWeakSelf(self)
    self.navigationItem.rightBarButtonItem = [GKBlockedBarButtonItem blockedBarButtonItemWithTitle:@"关于" eventHandler:^{
        [weakself.navigationController pushViewController:[[GKAboutViewController alloc] init] animated:YES];
    }];
}
@end
