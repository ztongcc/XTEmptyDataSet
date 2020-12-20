//
//  UIView+XTEmptyDataSet.h
//  Pods-XTEmptyDataSet_Example
//
//  Created by Jamis on 2020/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, XTEmptyDataSetType) {
    XTEmptyDataSetTypeIdle,
    XTEmptyDataSetTypeLoading,
    XTEmptyDataSetTypeNoData,
    XTEmptyDataSetTypeError,
    XTEmptyDataSetTypeCustom,
};


typedef NS_ENUM(NSInteger, XTDataSetStyle) {
    XTDataSetStyleNone,
    XTDataSetStyleIndicator,
    XTDataSetStyleImage,
    XTDataSetStyleText,
    XTDataSetStyleAction,
    XTDataSetStyleIndicatorText,
    XTDataSetStyleImageText,
    XTDataSetStyleImageAction,
    XTDataSetStyleTextAction,
    XTDataSetStyleCustomView
};

@interface XTDataSetView : UIView

@property (nonatomic, assign)CGPoint centerOffset;

+ (XTDataSetView *)dataSetViewWithStyle:(XTDataSetStyle)style;

- (void)reloadStyle:(XTDataSetStyle)style;

@end



@interface UIView (XTEmptyDataSet)

- (void)xt_setDataSet:(XTEmptyDataSetType)type style:(XTDataSetStyle)style;

- (void)xt_display:(XTEmptyDataSetType)type;

@end

NS_ASSUME_NONNULL_END
