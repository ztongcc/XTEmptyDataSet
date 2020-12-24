//
//  UITableView+XTEmptyDataSet.h
//  XTEmptyDataSet
//
//  Created by Jamis on 2020/12/23.
//

#import <UIKit/UIKit.h>
#import <UIView+XTEmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (XTEmptyDataSet)

- (void)xt_reloadDataIfEmptyDispaly:(XTEmptyDataSetType)type;

- (void)xt_reloadDataIfEmptyDispaly:(XTEmptyDataSetType)type updateData:(BOOL)isUpdate;
@end

NS_ASSUME_NONNULL_END
