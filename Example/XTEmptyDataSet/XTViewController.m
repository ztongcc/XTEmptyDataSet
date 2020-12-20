//
//  XTViewController.m
//  XTEmptyDataSet
//
//  Created by ztongcc on 12/20/2020.
//  Copyright (c) 2020 ztongcc. All rights reserved.
//

#import "XTViewController.h"
#import <UIView+XTEmptyDataSet.h>



@interface XTViewController ()

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view xt_setDataSet:XTEmptyDataSetTypeLoading style:XTDataSetStyleIndicator];
    [self.view xt_display:XTEmptyDataSetTypeLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
