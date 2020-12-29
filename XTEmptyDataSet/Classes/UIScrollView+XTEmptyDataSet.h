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
- (void)xt_captureStateIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isUpdate;

@end




@interface UITableView (XTEmptyDataSet)

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type;
- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isUpdate;

@end



@interface UICollectionView (XTEmptyDataSet)

- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type;
- (void)xt_reloadDataIfEmptyDisplay:(XTEmptyDataSetType)type refreshEmptyData:(BOOL)isUpdate;

@end



NS_ASSUME_NONNULL_END
