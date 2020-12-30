//
//  XTTestViewController.m
//  XTEmptyDataSet_Example
//
//  Created by ztong.cheng on 2020/12/29.
//  Copyright © 2020 ztongcc. All rights reserved.
//

#import "XTTestViewController.h"
#import <UIScrollView+XTEmptyDataSet.h>

@interface XTTestViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.tableView xt_updateEmptySetData:XTEmptyDataSetTypeLoading handler:^(XTDataSetConfig * _Nonnull config) {
        config.dataSetStyle = XTDataSetStyleIndicatorText;
        config.lableText = @"正在加载中...";
    }];
    
    [self.tableView xt_display:XTEmptyDataSetTypeLoading];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XTTestViewController * testVC = [[XTTestViewController alloc] initWithNibName:@"XTTestViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
