//
//  UICollectionView+XTEmptyDataSet.m
//  XTEmptyDataSet
//
//  Created by Jamis on 2020/12/23.
//

#import "UICollectionView+XTEmptyDataSet.h"

@implementation UICollectionView (XTEmptyDataSet)

- (NSInteger)xt_itemsCount
{
    NSInteger items = 0;
    // UIScollView doesn't respond to 'dataSource' so let's exit
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

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)need {
    [self reloadData];
    if ([self xt_shouldDispaly]) {
        [self xt_display:type refreshDataSet:need];
    }else {
        [self xt_hiddenEmptyDataSet];
    }
}

@end
