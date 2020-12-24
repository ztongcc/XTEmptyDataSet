//
//  XTViewController.m
//  XTEmptyDataSet
//
//  Created by ztongcc on 12/20/2020.
//  Copyright (c) 2020 ztongcc. All rights reserved.
//

#import "XTViewController.h"
#import <UIView+XTEmptyDataSet.h>



@interface XTViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view xt_setupEmptySetData:^(XTEmptyDataSetType type, XTDataSetConfig * _Nonnull config) {
        if (type == XTEmptyDataSetTypeLoading) {
            config.emptyStyle = XTDataSetStyleIndicator;
        }else if (type == XTEmptyDataSetTypeError) {
            config.emptyStyle = XTDataSetStyleText;
            config.text = @"网络出错";
        }else if (type == XTEmptyDataSetTypeNoData) {
            config.emptyStyle = XTDataSetStyleTextAction;
            config.text = @"暂无数据";
            config.buttonCornerRadius = 4;
            config.buttonBorderColor = [UIColor blueColor];
            config.buttonBorderWidth = 1;
            
            config.buttonNormalTitleColor = [UIColor blueColor];
            config.buttonTouchHandler = ^{
                NSLog(@"重试");
            };
        }
    }];
    
    
    [self.view xt_display:XTEmptyDataSetTypeLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view xt_display:XTEmptyDataSetTypeNoData];
    });
}

- (void)showDocumentPicker {
    NSArray *documentTypes = @[@"public.text",
                                   @"public.content",
                                   @"public.source-code",
                                   @"public.image",
                                   @"public.audiovisual-content",
                                   @"com.adobe.pdf",
                                   @"com.apple.keynote.key",
                                   @"com.microsoft.word.doc",
                                   @"com.microsoft.excel.xls",
                                   @"com.microsoft.powerpoint.ppt"];
        
        UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeImport];
        documentPickerViewController.delegate = self;
        documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:documentPickerViewController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showDocumentPicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
