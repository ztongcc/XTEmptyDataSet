//
//  UIScrollView+XTEmptyDataSet.m
//  XTEmptyDataSet
//
//  Created by Jamis on 2020/12/25.
//

#import "UIScrollView+XTEmptyDataSet.h"
#import <objc/runtime.h>

@implementation UIScrollView (XTEmptyDataSet)

- (NSInteger)xt_itemsCount {
    NSInteger items = 0;
    NSInteger (^ itemCountHandler)(void) = [self xt_itemCountHandler];
    if (itemCountHandler) {
        items = itemCountHandler();
    }
    return items;
}

- (NSInteger (^)(void))xt_itemCountHandler {
    NSInteger (^itemCountHandler)(void) = objc_getAssociatedObject(self, _cmd);
    return itemCountHandler;
}

- (void)setXt_itemCountHandler:(NSInteger (^)(void))xt_itemCountHandler {
    objc_setAssociatedObject(self, @selector(xt_itemCountHandler), xt_itemCountHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)xt_shouldDispaly {
    NSInteger itemsCount = [self xt_itemsCount];
    if (itemsCount > 0) {
        return NO;
    }
    return YES;
}

- (void)xt_captureStateIfEmptyDisplay:(XTEmptyDataSetType)type {
    [self xt_captureStateIfEmptyDisplay:type refreshEmptyData:NO];
}

- (void)xt_captureStateIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isUpdate {
    if ([self xt_shouldDispaly]) {
        [self xt_display:type refreshSetData:isUpdate];
    }else {
        [self xt_hiddenEmptyDataSet];
    }
}
@end



@implementation UITableView (XTEmptyDataSet)

- (NSInteger)xt_itemsCount {
    NSInteger items = 0;
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

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isRefresh {
    [self reloadData];
    if ([self xt_shouldDispaly]) {
        [self xt_display:type refreshSetData:isRefresh];
    }else {
        [self xt_hiddenEmptyDataSet];
    }
}

@end



@implementation UICollectionView (XTEmptyDataSet)

- (NSInteger)xt_itemsCount {
    NSInteger items = 0;
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;

        NSInteger sections = 1;
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
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

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isRefresh {
    [self reloadData];
    if ([self xt_shouldDispaly]) {
        [self xt_display:type refreshSetData:isRefresh];
    }else {
        [self xt_hiddenEmptyDataSet];
    }
}

@end
