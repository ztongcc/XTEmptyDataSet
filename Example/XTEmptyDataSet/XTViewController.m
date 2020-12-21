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
    [self.view xt_setEmptyDataSet:XTEmptyDataSetTypeLoading style:XTDataSetStyleIndicator];
    
    
    [self.view xt_display:XTEmptyDataSetTypeLoading];
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
