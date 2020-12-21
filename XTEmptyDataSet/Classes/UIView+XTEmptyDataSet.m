//
//  UIView+XTEmptyDataSet.m
//  Pods-XTEmptyDataSet_Example
//
//  Created by Jamis on 2020/12/20.
//

#import "UIView+XTEmptyDataSet.h"
#import <objc/runtime.h>

@interface UIView (XTEmptyViewLayoutConstraint)

@end


@implementation UIView (XTEmptyViewLayoutConstraint)

- (void)xt_addConstraint:(UIView *)item toView:(UIView *)toView position:(CGPoint)position {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toView?:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:position.x]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toView?:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:position.y]];
}

- (void)xt_addConstraint:(UIView *)item height:(CGFloat)height {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height]];
}

- (void)xt_addConstraint:(UIView *)item size:(CGSize)size {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:size.width]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:size.height]];
}

- (void)xt_addConstraint:(UIView *)item horizontalPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:padding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:padding]];
}

- (void)xt_addConstraint:(UIView *)item edgeInset:(UIEdgeInsets)edgeInset {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
}

@end



@interface XTDataSetView ()

@property (nonatomic, assign)XTDataSetStyle style;
@property (nonatomic, strong)UILabel * descriptionLable;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIActivityIndicatorView * indicatorView;
@property (nonatomic, strong)UIButton * actionButton;

@end

@implementation XTDataSetView

+ (XTDataSetView *)dataSetViewWithStyle:(XTDataSetStyle)style {
    XTDataSetView * dataSet = [[XTDataSetView alloc] initWithFrame:CGRectZero style:style];
    return dataSet;
}

- (id)initWithFrame:(CGRect)frame style:(XTDataSetStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        [self layout];
    }
    return self;
}

- (void)reloadStyle:(XTDataSetStyle)style {
    if (_style != style) {
        _style = style;
        [self clearAllLayoutViews];
        [self layout];
    }
}

- (void)clearAllLayoutViews {
    
}

- (void)layout {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    switch (self.style) {
        case XTDataSetStyleIndicator: {
            [self layoutIndicator];
            break;
        }
        case XTDataSetStyleText: {
            [self layoutText];
            break;
        }
        case XTDataSetStyleImage: {
            [self layoutImage];
            break;
        }
        case XTDataSetStyleAction: {
            [self layoutAction];
            break;
        }
        case XTDataSetStyleIndicatorText: {
            [self layoutIndicatorText];
            break;
        }
        case XTDataSetStyleImageText: {
            [self layoutImageText];
            break;
        }

        default:
            break;
    }
}

- (void)xt_dataSetViewWillAppear {
    if (self.style == XTDataSetStyleIndicator) {
        [self.indicatorView startAnimating];
    }
}

- (void)xt_dataSetViewWillDisappear {
    if (self.style == XTDataSetStyleIndicator) {
        [self.indicatorView stopAnimating];
    }
}

- (void)layoutIndicator {
    [self addSubview:self.indicatorView];
    [self xt_addConstraint:self.indicatorView toView:nil position:self.centerOffset];
}

- (void)layoutText {
    [self addSubview:self.descriptionLable];
    [self xt_addConstraint:self.descriptionLable toView:nil position:self.centerOffset];
}

- (void)layoutImage {
    [self addSubview:self.iconImageView];
    [self xt_addConstraint:self.iconImageView toView:nil position:self.centerOffset];
}

- (void)layoutAction {
    [self addSubview:self.actionButton];
    [self xt_addConstraint:self.actionButton toView:nil position:self.centerOffset];
    [self xt_addConstraint:self.actionButton height:40];
    [self xt_addConstraint:self.actionButton horizontalPadding:30];
}

- (void)layoutIndicatorText {
    [self addSubview:self.indicatorView];
    [self addSubview:self.descriptionLable];
    [self xt_addConstraint:self.indicatorView toView:nil position:self.centerOffset];
    
    [self xt_addConstraint:self.descriptionLable toView:self.indicatorView position:CGPointMake(0, self.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:30];
}

- (void)layoutImageText {
    [self addSubview:self.iconImageView];
    [self addSubview:self.descriptionLable];
    
    [self xt_addConstraint:self.iconImageView toView:nil position:self.centerOffset];
    
    [self xt_addConstraint:self.descriptionLable toView:self.iconImageView position:CGPointMake(0, self.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:30];
}


- (void)onTouchEvent {
    
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _indicatorView;
}

- (UILabel *)descriptionLable {
    if (!_descriptionLable) {
        _descriptionLable = [[UILabel alloc] init];
        _descriptionLable.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descriptionLable;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImageView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_actionButton addTarget:self action:@selector(onTouchEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}
@end

@implementation XTDataSetConfig

@end

@implementation UIView (XTEmptyDataSet)

- (NSDictionary *)defaultStypeData {
    return @{@(XTEmptyDataSetTypeLoading):@(XTDataSetStyleIndicator),
             @(XTEmptyDataSetTypeNoData):@(XTDataSetStyleImageText),
             @(XTEmptyDataSetTypeError):@(XTDataSetStyleTextAction)};
}

- (NSMutableDictionary *)xt_emptyDataSetStyleDictionary {
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:1];
        [dict addEntriesFromDictionary:[self defaultStypeData]];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary *)xt_emptyDataSetViewsDictionary {
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:1];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (void)xt_setEmptyDataSet:(XTEmptyDataSetType)type style:(XTDataSetStyle)style {
    NSMutableDictionary * styles = [self xt_emptyDataSetStyleDictionary];
    styles[@(type)] = @(style);
}

- (void)xt_setupEmptySetData:(XTDataSetConfig * (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler {
    
}

- (void)xt_display:(XTEmptyDataSetType)type {
    NSDictionary * dict = [self xt_emptyDataSetViewsDictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, XTDataSetView *_Nonnull obj, BOOL * _Nonnull stop) {
        [obj xt_dataSetViewWillDisappear];
        [obj removeFromSuperview];
    }];
    XTDataSetView * emptyView = (XTDataSetView *)dict[@(type)];
    if (!emptyView) {
        NSDictionary * styles = [self xt_emptyDataSetStyleDictionary];
        XTDataSetStyle style = styles[@(type)]?[styles[@(type)] integerValue]:XTDataSetStyleNone;
        emptyView = [XTDataSetView dataSetViewWithStyle:style];
    }

    [emptyView xt_dataSetViewWillAppear];
    
    [self addSubview:emptyView];
    [self xt_addConstraint:emptyView edgeInset:UIEdgeInsetsZero];
}

@end
