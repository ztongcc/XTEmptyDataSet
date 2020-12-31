//
//  UIScrollView+XTEmptyDataSet.h
//  XTEmptyDataSet
//
//  Created by Jamis on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import <UIView+XTEmptyDataSet.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (XTEmptyDataSet)

@property (nonatomic, copy)NSInteger (^xt_itemCountHandler)(void);

- (void)xt_captureStateIfEmptyDisplay:(XTEmptyDataSetType)type;
- (void)xt_captureStateIfEmptyDisplay:(XTEmptyDataSetType)type refreshDataSet:(BOOL)isRefresh;

@end




@interface UITableView (XTEmptyDataSet)

- (void)xt_dispalyIfEmpty:(XTEmptyDataSetType)type;
- (void)xt_dispalyIfEmpty:(XTEmptyDataSetType)type refreshDataSet:(BOOL)isRefresh;

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type;
- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshDataSet:(BOOL)isRefresh;

@end



@interface UICollectionView (XTEmptyDataSet)

- (void)xt_dispalyIfEmpty:(XTEmptyDataSetType)type;
- (void)xt_dispalyIfEmpty:(XTEmptyDataSetType)type refreshDataSet:(BOOL)isRefresh;

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type;
- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshDataSet:(BOOL)isRefresh;

@end



NS_ASSUME_NONNULL_END
