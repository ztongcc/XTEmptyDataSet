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

@class XTDataSetView;
@interface XTDataSetConfig : NSObject

@property (nonatomic, assign) XTDataSetStyle emptyStyle;
// 默认 XTDataSetLayoutCenter
@property (nonatomic, assign) XTDataSetLayout layoutStyle;

@property (nonatomic, strong) UIColor * backgroundColor;

// text
@property (nonatomic, assign) CGFloat lableHorizontalMargin;
@property (nonatomic, strong) UIFont * lableTextFont;
@property (nonatomic, strong) UIColor * lableTextColor;
@property (nonatomic,   copy) NSString * lableText;
@property (nonatomic,   copy) NSAttributedString * lableAttributedText;
@property (nonatomic, copy) void (^xt_configLableAppearance)(UILabel * sender);


// image
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, copy) void (^xt_configImageViewAppearance)(UIImageView * sender);


// actionButton
@property (nonatomic, assign) CGFloat    buttonHeight; // 默认 40
@property (nonatomic, assign) CGFloat    buttonHorizontalMargin; // 默认 30

@property (nonatomic,   copy) NSString * buttonNormalTitle; // 默认 点击重试
@property (nonatomic,   copy) NSString * buttonHighlightedTitle;
@property (nonatomic,   copy) NSAttributedString * buttonNormalAttributedTitle;
@property (nonatomic,   copy) NSAttributedString * buttonHighlightedAttributedTitle;

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

// 自定义
@property (nonatomic, copy) void (^xt_configButtonAppearance)(UIButton * sender);
@property (nonatomic, copy) dispatch_block_t buttonTouchHandler;


// customView
@property (nonatomic, strong) UIView * customView;
@property (nonatomic, assign) CGSize customViewSize;

// layout
// 整体居中的偏移量
@property (nonatomic, assign)CGPoint centerOffset;
// 元素之间纵轴间距 默认 30
@property (nonatomic, assign)CGFloat itemVerticalSpace;


// 生命周期
@property (nonatomic, copy)void (^xt_dataSetViewWillAppear)(XTDataSetView * setView, XTDataSetConfig * config);
@property (nonatomic, copy)void (^xt_dataSetViewWillDisappear)(XTDataSetView * setView, XTDataSetConfig * config);



+ (XTDataSetConfig *)blankIdle;

@end




@interface XTDataSetView : UIView

+ (XTDataSetView *)dataSetViewWithConfig:(XTDataSetConfig *)config;

- (void)refreshSetData;

@end




@interface UIView (XTEmptyDataSet)

// 全局设置
+ (void)xt_setupGlobalEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler UI_APPEARANCE_SELECTOR;
// 单独设置
- (void)xt_setupEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler;
// 针对单个页面进行更新
- (void)xt_updateEmptySetData:(XTEmptyDataSetType)type handler:(void (^)(XTDataSetConfig * config))handler;

- (void)xt_display:(XTEmptyDataSetType)type;

- (void)xt_display:(XTEmptyDataSetType)type refreshDataSet:(BOOL)refresh;

- (void)xt_hiddenEmptyDataSet;
- (void)xt_clearEmptyDataSet;

@end

NS_ASSUME_NONNULL_END
