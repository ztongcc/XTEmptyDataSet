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

@property (assign, nonatomic) NSInteger data;

@property (assign, nonatomic) NSInteger type;

@end

@implementation XTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem * empty = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(onReloadData)];
    self.navigationItem.rightBarButtonItem = empty;
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.tableView xt_updateEmptySetData:XTEmptyDataSetTypeError handler:^(XTDataSetConfig * _Nonnull config) {
        config.buttonTouchHandler = ^{
            [self onReloadData];
        };
    }];
        
    [self.tableView xt_display:XTEmptyDataSetTypeLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.data = 10;
        [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
    });
}

- (void)onReloadData {
    self.type ++;
    [self.tableView xt_dispalyIfEmpty:XTEmptyDataSetTypeLoading];
    if (self.type % 3 == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.data = 0;
            [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
        });
    }else if (self.type % 3 == 2) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.data = 0;
            [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeError];
        });
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.data = 10;
            [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
        });
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data;
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
