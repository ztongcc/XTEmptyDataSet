//
//  UIView+XTEmptyDataSet.m
//  Pods-XTEmptyDataSet_Example
//
//  Created by Jamis on 2020/12/20.
//

#import "UIView+XTEmptyDataSet.h"
#import <objc/runtime.h>

@interface UIView (XTEmptyViewLayoutConstraint)

- (void)xt_addConstraint:(NSLayoutConstraint *)constraint;

@end


@implementation UIView (XTEmptyViewLayoutConstraint)

- (void)xt_addConstraint:(NSLayoutConstraint *)constraint {
    constraint.active = YES;
    [self addConstraint:constraint];
}

- (void)xt_addConstraint:(UIView *)item position:(CGPoint)position {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:position.x]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:position.y]];
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
            [self addSubview:self.actionButton];
            break;
        }
        case XTDataSetStyleIndicatorText: {
            [self addSubview:self.descriptionLable];
            break;
        }
        case XTDataSetStyleImageText: {
            [self addSubview:self.descriptionLable];
            break;
        }

        default:
            break;
    }
}

- (void)layoutIndicator {
    [self addSubview:self.indicatorView];
    
    [self xt_addConstraint:self.indicatorView position:self.centerOffset];
    
    [self.indicatorView startAnimating];
}

- (void)layoutText {
    [self addSubview:self.descriptionLable];
}

- (void)layoutImage {
    [self addSubview:self.descriptionLable];
}



- (void)onTouchEvent {
    
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

- (UILabel *)descriptionLable {
    if (!_descriptionLable) {
        _descriptionLable = [[UILabel alloc] init];
    }
    return _descriptionLable;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
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


@implementation UIView (XTEmptyDataSet)

- (NSDictionary *)defaultStypeData {
    return @{@(XTEmptyDataSetTypeLoading):@(XTDataSetStyleIndicator),
             @(XTEmptyDataSetTypeNoData):@(XTDataSetStyleImageText),
             @(XTEmptyDataSetTypeError):@(XTDataSetStyleTextAction)
    };
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

- (void)xt_setDataSet:(XTEmptyDataSetType)type style:(XTDataSetStyle)style {
    NSMutableDictionary * styles = [self xt_emptyDataSetStyleDictionary];
    styles[@(type)] = @(style);
}

- (void)xt_display:(XTEmptyDataSetType)type {
    NSDictionary * dict = [self xt_emptyDataSetViewsDictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIView *_Nonnull obj, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    UIView * emptyView = dict[@(type)];
    if (!emptyView) {
        NSDictionary * styles = [self xt_emptyDataSetStyleDictionary];
        XTDataSetStyle style = styles[@(type)]?[styles[@(type)] integerValue]:XTDataSetStyleNone;
        emptyView = [XTDataSetView dataSetViewWithStyle:style];
    }

    [self xt_addConstraint:emptyView edgeInset:UIEdgeInsetsZero];
    [self addSubview:emptyView];
}

@end
