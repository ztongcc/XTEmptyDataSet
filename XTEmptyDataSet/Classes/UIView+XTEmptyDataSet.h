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
// 元素之间纵轴间距
@property (nonatomic, assign)CGFloat itemVerticalSpace;

+ (XTDataSetView *)dataSetViewWithStyle:(XTDataSetStyle)style;

- (void)reloadStyle:(XTDataSetStyle)style;


- (void)xt_dataSetViewWillAppear;
- (void)xt_dataSetViewWillDisappear;

@end


@interface XTDataSetConfig : NSObject

@property (nonatomic, copy) NSString * text;

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong) UIView * customView;

@end




@interface UIView (XTEmptyDataSet)

- (void)xt_setEmptyDataSet:(XTEmptyDataSetType)type style:(XTDataSetStyle)style;

- (void)xt_setupEmptySetData:(XTDataSetConfig * (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler;

- (void)xt_display:(XTEmptyDataSetType)type;

@end

NS_ASSUME_NONNULL_END
