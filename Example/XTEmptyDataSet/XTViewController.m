//
//  XTViewController.m
//  XTEmptyDataSet
//
//  Created by ztongcc on 12/20/2020.
//  Copyright (c) 2020 ztongcc. All rights reserved.
//

#import "XTViewController.h"
#import <UIScrollView+XTEmptyDataSet.h>
#import "XTTestViewController.h"

@interface XTViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger data;

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [UIView new];

    [self.tableView xt_display:XTEmptyDataSetTypeLoading];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.data = 10;
        [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
    });
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
