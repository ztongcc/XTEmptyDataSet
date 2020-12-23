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

- (void)xt_addConstraint:(UIView *)item offset:(CGPoint)offset layout:(XTDataSetLayout)layout {
    NSLayoutAttribute attribute = NSLayoutAttributeCenterY;
    if (layout == XTDataSetLayoutTop) {
        attribute = NSLayoutAttributeTop;
    }else if (layout == XTDataSetLayoutBotom) {
        attribute = NSLayoutAttributeBottom;
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1 constant:offset.y]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset.x]];
}

- (void)xt_addRelativeConstraint:(UIView *)item toView:(UIView *)toView offset:(CGPoint)offset {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toView?:self attribute:NSLayoutAttributeBottom multiplier:1 constant:offset.y]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toView?:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset.x]];
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-padding]];
}

- (void)xt_addConstraint:(UIView *)item edgeInset:(UIEdgeInsets)edgeInset {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
}

@end



@implementation XTDataSetConfig

+ (XTDataSetConfig *)blankIdle {
    XTDataSetConfig * config = [[XTDataSetConfig alloc] init];
    config.emptyStyle = XTDataSetStyleNone;
    return config;
}
// text default config
- (CGFloat)textHorizontalMargin {
    return _textHorizontalMargin > 0?_textHorizontalMargin:30;
}

// button default config
- (CGFloat)buttonHeight {
    return _buttonHeight > 0?_buttonHeight:40;
}
- (CGFloat)buttonHorizontalMargin {
    return _buttonHorizontalMargin > 0?_buttonHorizontalMargin:30;
}
- (NSString *)buttonNormalTitle {
    return _buttonNormalTitle?_buttonNormalTitle:@"点击重试";
}

- (CGFloat)itemVerticalSpace {
    return _itemVerticalSpace > 0?_itemVerticalSpace:30;

}

@end



@interface XTDataSetView ()

@property (nonatomic, assign)XTDataSetStyle  currentStyle;
@property (nonatomic, strong)XTDataSetConfig * config;
@property (nonatomic, strong)UILabel * descriptionLable;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIActivityIndicatorView * indicatorView;
@property (nonatomic, strong)UIButton * actionButton;

@end

@implementation XTDataSetView

+ (XTDataSetView *)dataSetViewWithConfig:(XTDataSetConfig *)config {
    XTDataSetView * dataSet = [[XTDataSetView alloc] initWithFrame:CGRectZero config:config];
    return dataSet;
}

- (id)initWithFrame:(CGRect)frame config:(XTDataSetConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        _currentStyle = config.emptyStyle;
        [self layout];
        [self bindData];
    }
    return self;
}

- (void)reloadData {
    if (_currentStyle != self.config.emptyStyle) {
        [self clearAllLayoutViews];
        [self layout];
    }
    [self bindData];
}

- (void)clearAllLayoutViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray * constraints = self.constraints;
    for (NSLayoutConstraint * constraint in constraints) {
        [self removeConstraint:constraint];
    }
}

- (void)bindData {
    self.backgroundColor = self.config.backgroundColor;
    NSDictionary * layouts = @{@(XTDataSetStyleText):@"bindText",
                               @(XTDataSetStyleImage):@"bindImage",
                               @(XTDataSetStyleAction):@"bindAction",
                               @(XTDataSetStyleIndicatorText):@"bindIndicatorText",
                               @(XTDataSetStyleImageText):@"bindImageText",
                               @(XTDataSetStyleImageAction):@"bindImageAction",
                               @(XTDataSetStyleTextAction):@"bindTextAction"};
    
    SEL selector = NSSelectorFromString(layouts[@(self.config.emptyStyle)]);
    if (selector) {
        NSMethodSignature * signature = [self methodSignatureForSelector:selector];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        [invocation invoke];
    }
}

- (void)layout {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary * layouts = @{@(XTDataSetStyleIndicator):@"layoutIndicator",
                               @(XTDataSetStyleText):@"layoutText",
                               @(XTDataSetStyleImage):@"layoutImage",
                               @(XTDataSetStyleAction):@"layoutAction",
                               @(XTDataSetStyleIndicatorText):@"layoutIndicatorText",
                               @(XTDataSetStyleImageText):@"layoutImageText",
                               @(XTDataSetStyleImageAction):@"layoutImageAction",
                               @(XTDataSetStyleTextAction):@"layoutTextAction",
                               @(XTDataSetStyleCustomView):@"layoutCustomView"};
    
    SEL selector = NSSelectorFromString(layouts[@(self.config.emptyStyle)]);
    if (selector) {
        NSMethodSignature * signature = [self methodSignatureForSelector:selector];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        [invocation invoke];
    }
}

- (void)xt_dataSetViewWillAppear {
    if (self.config.emptyStyle == XTDataSetStyleIndicator) {
        [self.indicatorView startAnimating];
    }
}

- (void)xt_dataSetViewWillDisappear {
    if (self.config.emptyStyle == XTDataSetStyleIndicator) {
        [self.indicatorView stopAnimating];
    }
}

#pragma mark -
- (void)bindText {
    self.descriptionLable.font = _config.textFont;
    self.descriptionLable.textColor = _config.textColor;
    self.descriptionLable.attributedText = _config.attributedText;
    self.descriptionLable.text = _config.text;
}

- (void)bindImage {
    self.iconImageView.image = _config.image;
}

- (void)bindAction {
    [self.actionButton setTitle:_config.buttonNormalTitle forState:UIControlStateNormal];
    [self.actionButton setTitle:_config.buttonHighlightedTitle forState:UIControlStateHighlighted];
    [self.actionButton setTitleColor:_config.buttonNormalTitleColor forState:UIControlStateNormal];
    [self.actionButton setTitleColor:_config.buttonHighlightedTitleColor forState:UIControlStateHighlighted];
    [self.actionButton setImage:_config.buttonNormalImage forState:UIControlStateNormal];
    [self.actionButton setImage:_config.buttonHighlightedImage forState:UIControlStateHighlighted];
    self.actionButton.titleLabel.font = _config.buttonNormalFont;
    self.actionButton.backgroundColor = _config.buttonBackgroundColor;
    self.actionButton.layer.borderWidth = _config.buttonBorderWidth;
    self.actionButton.layer.borderColor = _config.buttonBorderColor.CGColor;
    self.actionButton.layer.cornerRadius = _config.buttonCornerRadius;
}

- (void)bindIndicatorText {
    [self bindText];
}

- (void)bindImageText {
    [self bindImage];
    [self bindText];
}

- (void)bindImageAction {
    [self bindImage];
    [self bindAction];
}

- (void)bindTextAction {
    [self bindText];
    [self bindAction];
}

#pragma mark -
- (void)layoutIndicator {
    [self addSubview:self.indicatorView];
    [self xt_addConstraint:self.indicatorView offset:_config.centerOffset layout:_config.layoutStyle];
}

- (void)layoutText {
    [self addSubview:self.descriptionLable];
    [self xt_addConstraint:self.descriptionLable offset:_config.centerOffset layout:_config.layoutStyle];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.textHorizontalMargin];
}

- (void)layoutImage {
    [self addSubview:self.iconImageView];
    CGSize size = CGSizeEqualToSize(CGSizeZero, _config.imageSize)?_config.image.size:_config.imageSize;
    [self xt_addConstraint:self.iconImageView size:size];
    [self xt_addConstraint:self.iconImageView offset:_config.centerOffset layout:_config.layoutStyle];
}

- (void)layoutAction {
    [self addSubview:self.actionButton];
    [self xt_addConstraint:self.actionButton offset:_config.centerOffset layout:_config.layoutStyle];
    [self xt_addConstraint:self.actionButton height:_config.buttonHeight];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
}

- (void)layoutIndicatorText {
    [self addSubview:self.indicatorView];
    [self addSubview:self.descriptionLable];
    [self xt_addConstraint:self.indicatorView offset:_config.centerOffset layout:_config.layoutStyle];
    
    [self xt_addRelativeConstraint:self.descriptionLable toView:self.indicatorView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.textHorizontalMargin];
}

- (void)layoutImageText {
    [self addSubview:self.iconImageView];
    [self addSubview:self.descriptionLable];
    
    [self xt_addConstraint:self.iconImageView offset:_config.centerOffset layout:_config.layoutStyle];
    
    [self xt_addRelativeConstraint:self.descriptionLable toView:self.iconImageView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.textHorizontalMargin];
}

- (void)layoutImageAction {
    [self addSubview:self.iconImageView];
    [self addSubview:self.actionButton];
    
    [self xt_addConstraint:self.iconImageView offset:_config.centerOffset layout:_config.layoutStyle];
    
    [self xt_addRelativeConstraint:self.actionButton toView:self.iconImageView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
}

- (void)layoutTextAction {
    [self addSubview:self.descriptionLable];
    [self addSubview:self.actionButton];
    
    [self xt_addConstraint:self.descriptionLable offset:_config.centerOffset layout:_config.layoutStyle];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.textHorizontalMargin];

    [self xt_addRelativeConstraint:self.actionButton toView:self.descriptionLable offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
    [self xt_addConstraint:self.actionButton height:_config.buttonHeight];
}

- (void)layoutCustomView {
    [self addSubview:_config.customView];
    _config.customView.translatesAutoresizingMaskIntoConstraints = NO;
    CGSize size = CGSizeEqualToSize(CGSizeZero, _config.customViewSize)?_config.customView.bounds.size:_config.customViewSize;
    [self xt_addConstraint:_config.customView size:size];
    [self xt_addConstraint:_config.customView offset:_config.centerOffset layout:_config.layoutStyle];
}

- (void)onTouchEvent {
    if (_config.buttonTouchHandler) {
        _config.buttonTouchHandler();
    }
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
        _descriptionLable.textAlignment = NSTextAlignmentCenter;
        _descriptionLable.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descriptionLable;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImageView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_actionButton addTarget:self action:@selector(onTouchEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}
@end

@implementation UIView (XTEmptyDataSet)

- (NSMutableDictionary *)xt_emptyDataSetConfigsDictionary {
    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:1];
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

- (void)xt_setupEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler {
    NSArray * types = @[@(XTEmptyDataSetTypeIdle), @(XTEmptyDataSetTypeLoading), @(XTEmptyDataSetTypeNoData),
                        @(XTEmptyDataSetTypeError),@(XTEmptyDataSetTypeCustom)];
    __block NSMutableDictionary * tmp = [NSMutableDictionary dictionaryWithCapacity:1];
    [types enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XTDataSetConfig * config = [[XTDataSetConfig alloc] init];
        if (handler) {
            handler([obj integerValue], config);
        }
        [tmp setObject:config forKey:obj];
    }];
    NSMutableDictionary * configs = [self xt_emptyDataSetConfigsDictionary];
    [configs removeAllObjects];
    [configs addEntriesFromDictionary:tmp];
}

- (void)xt_updateEmptySetData:(XTEmptyDataSetType)type handler:(void (^)(XTDataSetConfig * config))handler {
    NSMutableDictionary * configs = [self xt_emptyDataSetConfigsDictionary];
    __block XTDataSetConfig * config;
    [configs enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, XTDataSetConfig *_Nonnull obj, BOOL * _Nonnull stop) {
        if ([key integerValue] == type) {
            config = obj;
        }
    }];
    
    if (config == nil) {
        config = [[XTDataSetConfig alloc] init];
        [configs setObject:config forKey:@(type)];
    }
    
    if (handler) {
        handler(config);
    }
}

- (void)xt_display:(XTEmptyDataSetType)type {
    [self xt_display:type reloadData:NO];
}

- (void)xt_display:(XTEmptyDataSetType)type reloadData:(BOOL)reload {
    [self xt_hiddenEmptyDataSet];
    
    NSMutableDictionary * viewsDict = [self xt_emptyDataSetViewsDictionary];
    XTDataSetView * emptyView = (XTDataSetView *)viewsDict[@(type)];
    if (!emptyView) {
        NSDictionary * styles = [self xt_emptyDataSetConfigsDictionary];
        XTDataSetConfig * config = styles[@(type)];
        if (!config) {
            config = [XTDataSetConfig blankIdle];
        }
        emptyView = [XTDataSetView dataSetViewWithConfig:config];
        viewsDict[@(type)] = emptyView;
    }
    
    if (reload) {
        [emptyView reloadData];
    }

    [emptyView xt_dataSetViewWillAppear];
    
    [self addSubview:emptyView];
    [self xt_addConstraint:emptyView edgeInset:UIEdgeInsetsZero];
}

- (void)xt_hiddenEmptyDataSet {
    NSDictionary * dict = [self xt_emptyDataSetViewsDictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, XTDataSetView *_Nonnull obj, BOOL * _Nonnull stop) {
        [obj xt_dataSetViewWillDisappear];
        [obj removeFromSuperview];
    }];
}

@end

