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

typedef NS_ENUM(NSInteger, XTDataSetLayout) {
    XTDataSetLayoutCenter,
    XTDataSetLayoutTop,
    XTDataSetLayoutBotom,
};

@interface XTDataSetConfig : NSObject

@property (nonatomic, assign) XTDataSetStyle emptyStyle;
// 默认 XTDataSetLayoutCenter
@property (nonatomic, assign) XTDataSetLayout layoutStyle;

@property (nonatomic, strong) UIColor * backgroundColor;

// text
@property (nonatomic, assign) CGFloat textHorizontalMargin;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) UIFont * textFont;
@property (nonatomic, copy) NSAttributedString * attributedText;

// image
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) CGSize imageSize;

// actionButton
@property (nonatomic, assign) CGFloat    buttonHeight; // 默认 40
@property (nonatomic, assign) CGFloat    buttonHorizontalMargin; // 默认 30
@property (nonatomic,   copy) NSString * buttonNormalTitle; // 默认 点击重试
@property (nonatomic,   copy) NSString * buttonHighlightedTitle;
@property (nonatomic, strong) UIColor *  buttonNormalTitleColor;
@property (nonatomic, strong) UIColor *  buttonHighlightedTitleColor;
@property (nonatomic, strong) UIFont *   buttonNormalFont;
@property (nonatomic, strong) UIFont *   buttonHighlightedFont;
@property (nonatomic, strong) UIImage *  buttonNormalImage;
@property (nonatomic, strong) UIImage *  buttonHighlightedImage;
@property (nonatomic, strong) UIColor *  buttonBackgroundColor;
@property (nonatomic, assign) CGFloat    buttonCornerRadius;
@property (nonatomic, assign) CGFloat    buttonBorderWidth;
@property (nonatomic, strong) UIColor *  buttonBorderColor;
@property (nonatomic, copy) dispatch_block_t buttonTouchHandler;


// customView
@property (nonatomic, strong) UIView * customView;
@property (nonatomic, assign) CGSize customViewSize;

// layout
// 整体居中的偏移量
@property (nonatomic, assign)CGPoint centerOffset;
// 元素之间纵轴间距 默认 30
@property (nonatomic, assign)CGFloat itemVerticalSpace;

+ (XTDataSetConfig *)blankIdle;

@end




@interface XTDataSetView : UIView


+ (XTDataSetView *)dataSetViewWithConfig:(XTDataSetConfig *)config;

- (void)reloadData;


- (void)xt_dataSetViewWillAppear;
- (void)xt_dataSetViewWillDisappear;

@end




@interface UIView (XTEmptyDataSet)

- (void)xt_setupEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler;

- (void)xt_updateEmptySetData:(XTEmptyDataSetType)type handler:(void (^)(XTDataSetConfig * config))handler;

- (void)xt_display:(XTEmptyDataSetType)type;

- (void)xt_display:(XTEmptyDataSetType)type reloadData:(BOOL)reload;

- (void)xt_hiddenEmptyDataSet;

@end

NS_ASSUME_NONNULL_END
