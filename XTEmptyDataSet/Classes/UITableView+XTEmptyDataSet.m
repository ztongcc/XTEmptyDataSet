//
//  UITableView+XTEmptyDataSet.m
//  XTEmptyDataSet
//
//  Created by Jamis on 2020/12/23.
//

#import "UITableView+XTEmptyDataSet.h"

@implementation UITableView (XTEmptyDataSet)

- (NSInteger)xt_itemsCount
{
    NSInteger items = 0;
    // UIScollView doesn't respond to 'dataSource' so let's exit
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        NSInteger sections = 1;
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    return items;
}

- (BOOL)xt_shouldDispaly {
    NSInteger itemsCount = [self xt_itemsCount];
    if (itemsCount > 0) {
        return NO;
    }
    return YES;
}

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type {
    [self xt_reloadDataIfEmptyDisplay:type refreshEmptyData:NO];
}

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isNeed {
    [self reloadData];
    if ([self xt_shouldDispaly]) {
        [self xt_display:type refreshDataSet:isNeed];
    }else {
        [self xt_hiddenEmptyDataSet];
    }
}

@end
