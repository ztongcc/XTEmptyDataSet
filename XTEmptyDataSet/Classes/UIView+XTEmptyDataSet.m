//
//  UIView+XTEmptyDataSet.m
//  Pods-XTEmptyDataSet_Example
//
//  Created by Jamis on 2020/12/20.
//

#import "UIView+XTEmptyDataSet.h"
#import <objc/runtime.h>


static NSMutableDictionary * xt_globalConfigs;

CGPoint XTPointMakeOffSetY(CGPoint point, CGFloat diffY) {
    point.y += diffY;
    return point;
}

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

- (void)xt_addConstraintToScrollView:(UIView *)item edgeInset:(UIEdgeInsets)edgeInset {
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:(edgeInset.top - edgeInset.bottom)/2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:(edgeInset.left - edgeInset.right)/2]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-(edgeInset.left + edgeInset.right)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:-(edgeInset.top + edgeInset.bottom)]];
}


@end



@implementation XTDataSetConfig

+ (XTDataSetConfig *)blankIdle {
    XTDataSetConfig * config = [[XTDataSetConfig alloc] init];
    config.dataSetStyle = XTDataSetStyleNone;
    return config;
}

- (void)mergeDataFrom:(XTDataSetConfig *)config {
    self.dataSetStyle = config.dataSetStyle;
    self.dataSetLayout = config.dataSetLayout;
    self.backgroundColor = config.backgroundColor;
    
    self.lableText = config.lableText;
    self.lableTextFont = config.lableTextFont;
    self.lableTextColor = config.lableTextColor;
    self.lableAttributedText = config.lableAttributedText;
    self.lableHorizontalMargin = config.lableHorizontalMargin;
    self.xt_configLableAppearance = config.xt_configLableAppearance;
    
    self.buttonHeight = config.buttonHeight;
    self.buttonBorderColor = config.buttonBorderColor;
    self.buttonCornerRadius = config.buttonCornerRadius;
    self.buttonBorderWidth = config.buttonBorderWidth;
    self.buttonBackgroundColor = config.buttonBackgroundColor;

    self.buttonNormalFont = config.buttonNormalFont;
    self.buttonNormalImage = config.buttonNormalImage;
    self.buttonNormalTitle = config.buttonNormalTitle;
    self.buttonNormalTitleColor = config.buttonNormalTitleColor;
    self.buttonNormalAttributedTitle = config.buttonNormalAttributedTitle;
    self.buttonHighlightedFont = config.buttonHighlightedFont;
    self.buttonHighlightedImage = config.buttonHighlightedImage;
    self.buttonHighlightedTitle = config.buttonHighlightedTitle;
    self.buttonHighlightedTitleColor = config.buttonHighlightedTitleColor;
    self.buttonHighlightedAttributedTitle = config.buttonHighlightedAttributedTitle;
    self.xt_configButtonAppearance = config.xt_configButtonAppearance;
    
    self.image = config.image;
    self.imageSize = config.imageSize;
    self.xt_configImageViewAppearance = config.xt_configImageViewAppearance;
    
    self.customView = config.customView;
    self.customViewSize = config.customViewSize;
    
    self.centerOffset = config.centerOffset;
    self.itemVerticalSpace = config.itemVerticalSpace;
    self.edgeMarginInsets = config.edgeMarginInsets;
}

- (CGSize)lableBoundingSize {
    CGSize size = CGSizeZero;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    maxWidth = maxWidth - self.lableHorizontalMargin * 2;
    
    if (self.lableAttributedText) {
        size = [self.lableAttributedText boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    }else {
        NSAttributedString * text = [[NSAttributedString alloc] initWithString:self.lableText?:@"" attributes:@{NSFontAttributeName:self.lableTextFont}];
        size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    }
    return size;
}

// text default config
- (CGFloat)lableHorizontalMargin {
    return _lableHorizontalMargin > 0?_lableHorizontalMargin:30;
}
- (UIFont *)lableTextFont {
    return _lableTextFont?_lableTextFont:[UIFont systemFontOfSize:15];
}

// image
- (CGSize)imageSize {
    if (!CGSizeEqualToSize(_imageSize, CGSizeZero)) {
        return _imageSize;
    }
    if (_image) {
        return _image.size;
    }
    return CGSizeZero;
}

// button default config
- (CGFloat)buttonHeight {
    return _buttonHeight > 0?_buttonHeight:36;
}
- (CGFloat)buttonHorizontalMargin {
    return _buttonHorizontalMargin > 0?_buttonHorizontalMargin:30;
}
- (NSString *)buttonNormalTitle {
    return _buttonNormalTitle?_buttonNormalTitle:@"点击重试";
}

- (CGFloat)itemVerticalSpace {
    return _itemVerticalSpace > 0?_itemVerticalSpace:20;
}
@end



@interface XTDataSetView ()

@property (nonatomic, assign)XTDataSetStyle  currentDataSetStyle;
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
        _config = config;
        _currentDataSetStyle = config.dataSetStyle;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self layout];
        [self bindData];
    }
    return self;
}

- (void)refreshDataSet {
    if (_currentDataSetStyle != self.config.dataSetStyle) {
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
    NSDictionary * layouts = @{@(XTDataSetStyleIndicator):@"bindIndicator",
                               @(XTDataSetStyleText):@"bindText",
                               @(XTDataSetStyleImage):@"bindImage",
                               @(XTDataSetStyleAction):@"bindAction",
                               @(XTDataSetStyleIndicatorText):@"bindIndicatorText",
                               @(XTDataSetStyleImageText):@"bindImageText",
                               @(XTDataSetStyleImageAction):@"bindImageAction",
                               @(XTDataSetStyleTextAction):@"bindTextAction"};
    
    SEL selector = NSSelectorFromString(layouts[@(self.config.dataSetStyle)]);
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
    
    SEL selector = NSSelectorFromString(layouts[@(self.config.dataSetStyle)]);
    if (selector) {
        NSMethodSignature * signature = [self methodSignatureForSelector:selector];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        [invocation invoke];
    }
}

- (void)xt_dataSetViewWillAppear {
    if (_config.dataSetStyle == XTDataSetStyleIndicator ||
        _config.dataSetStyle == XTDataSetStyleIndicatorText) {
        [self.indicatorView startAnimating];
    }
    if (_config.xt_dataSetViewWillAppear) {
        _config.xt_dataSetViewWillAppear(self, _config);
    }
}

- (void)xt_dataSetViewWillDisappear {
    if (_config.dataSetStyle == XTDataSetStyleIndicator ||
        _config.dataSetStyle == XTDataSetStyleIndicatorText) {
        [self.indicatorView stopAnimating];
    }
    
    if (_config.xt_dataSetViewWillDisappear) {
        _config.xt_dataSetViewWillDisappear(self, _config);
    }
}

#pragma mark -

- (void)bindIndicator {
    self.indicatorView.activityIndicatorViewStyle = _config.indicatorViewStyle;
    if (_config.indicatorColor) {
        self.indicatorView.color = _config.indicatorColor;
    }
}

- (void)bindText {
    self.descriptionLable.font = _config.lableTextFont;
    self.descriptionLable.textColor = _config.lableTextColor;
    self.descriptionLable.attributedText = _config.lableAttributedText;
    self.descriptionLable.text = _config.lableText;
    if (_config.xt_configLableAppearance) {
        _config.xt_configLableAppearance(self.descriptionLable);
    }
}

- (void)bindImage {
    if (_config.xt_configImageViewAppearance) {
        _config.xt_configImageViewAppearance(self.iconImageView);
    }
    self.iconImageView.image = _config.image;
}

- (void)bindAction {
    
    [self.actionButton setTitle:_config.buttonNormalTitle forState:UIControlStateNormal];
    [self.actionButton setTitle:_config.buttonHighlightedTitle forState:UIControlStateHighlighted];
    if (_config.buttonNormalAttributedTitle) {
        [self.actionButton setAttributedTitle:_config.buttonNormalAttributedTitle forState:UIControlStateNormal];
    }
    if (_config.buttonHighlightedAttributedTitle) {
        [self.actionButton setAttributedTitle:_config.buttonHighlightedAttributedTitle forState:UIControlStateHighlighted];
    }
    [self.actionButton setTitleColor:_config.buttonNormalTitleColor forState:UIControlStateNormal];
    [self.actionButton setTitleColor:_config.buttonHighlightedTitleColor forState:UIControlStateHighlighted];
    [self.actionButton setImage:_config.buttonNormalImage forState:UIControlStateNormal];
    [self.actionButton setImage:_config.buttonHighlightedImage forState:UIControlStateHighlighted];
    self.actionButton.titleLabel.font = _config.buttonNormalFont;
    self.actionButton.backgroundColor = _config.buttonBackgroundColor;
    self.actionButton.layer.borderWidth = _config.buttonBorderWidth;
    self.actionButton.layer.borderColor = _config.buttonBorderColor.CGColor;
    self.actionButton.layer.cornerRadius = _config.buttonCornerRadius;
    if (_config.xt_configButtonAppearance) {
        _config.xt_configButtonAppearance(self.actionButton);
    }
}

- (void)bindIndicatorText {
    [self bindIndicator];
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
    [self xt_addConstraint:self.indicatorView offset:_config.centerOffset layout:_config.dataSetLayout];
}

- (void)layoutText {
    [self addSubview:self.descriptionLable];
    [self xt_addConstraint:self.descriptionLable offset:_config.centerOffset layout:_config.dataSetLayout];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.lableHorizontalMargin];
}

- (void)layoutImage {
    [self addSubview:self.iconImageView];
    if (CGSizeEqualToSize(CGSizeZero, _config.imageSize)) {
        [self xt_addConstraint:self.iconImageView size:_config.imageSize];
    }
    [self xt_addConstraint:self.iconImageView offset:_config.centerOffset layout:_config.dataSetLayout];
}

- (void)layoutAction {
    [self addSubview:self.actionButton];
    [self xt_addConstraint:self.actionButton offset:_config.centerOffset layout:_config.dataSetLayout];
    [self xt_addConstraint:self.actionButton height:_config.buttonHeight];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
}

- (void)layoutIndicatorText {
    [self addSubview:self.indicatorView];
    [self addSubview:self.descriptionLable];
    
    CGSize textSize = [_config lableBoundingSize];
    
    CGFloat diffOff = (textSize.height + _config.itemVerticalSpace + CGRectGetHeight(_indicatorView.bounds))/2;
    [self xt_addConstraint:self.indicatorView offset:XTPointMakeOffSetY(_config.centerOffset, - diffOff) layout:_config.dataSetLayout];

    [self xt_addRelativeConstraint:self.descriptionLable toView:self.indicatorView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.lableHorizontalMargin];
}

- (void)layoutImageText {
    [self addSubview:self.iconImageView];
    [self addSubview:self.descriptionLable];
    
    CGSize textSize = [_config lableBoundingSize];
    CGFloat diffOff = (textSize.height + _config.itemVerticalSpace + _config.imageSize.height)/2;
    
    [self xt_addConstraint:self.iconImageView offset:XTPointMakeOffSetY(_config.centerOffset, - diffOff) layout:_config.dataSetLayout];
    [self xt_addConstraint:self.iconImageView size:_config.imageSize];

    [self xt_addRelativeConstraint:self.descriptionLable toView:self.iconImageView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.lableHorizontalMargin];
}

- (void)layoutImageAction {
    [self addSubview:self.iconImageView];
    [self addSubview:self.actionButton];
    
    CGFloat diffOff = (_config.imageSize.height + _config.itemVerticalSpace + _config.buttonHeight)/2;
    
    [self xt_addConstraint:self.iconImageView offset:XTPointMakeOffSetY(_config.centerOffset, - diffOff) layout:_config.dataSetLayout];
    
    [self xt_addRelativeConstraint:self.actionButton toView:self.iconImageView offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
    [self xt_addConstraint:self.actionButton height:_config.buttonHeight];
}

- (void)layoutTextAction {
    [self addSubview:self.descriptionLable];
    [self addSubview:self.actionButton];
    
    CGSize textSize = [_config lableBoundingSize];
    CGFloat diffOff = (_config.buttonHeight + _config.itemVerticalSpace + textSize.height)/2;
  
    [self xt_addConstraint:self.descriptionLable offset:XTPointMakeOffSetY(_config.centerOffset, - diffOff) layout:_config.dataSetLayout];
    [self xt_addConstraint:self.descriptionLable horizontalPadding:_config.lableHorizontalMargin];

    [self xt_addRelativeConstraint:self.actionButton toView:self.descriptionLable offset:CGPointMake(0, _config.itemVerticalSpace)];
    [self xt_addConstraint:self.actionButton horizontalPadding:_config.buttonHorizontalMargin];
    [self xt_addConstraint:self.actionButton height:_config.buttonHeight];
}

- (void)layoutCustomView {
    [self addSubview:_config.customView];
    _config.customView.translatesAutoresizingMaskIntoConstraints = NO;
    CGSize size = CGSizeEqualToSize(CGSizeZero, _config.customViewSize)?_config.customView.bounds.size:_config.customViewSize;
    [self xt_addConstraint:_config.customView size:size];
    [self xt_addConstraint:_config.customView offset:_config.centerOffset layout:_config.dataSetLayout];
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
        _descriptionLable.numberOfLines = 0;
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

+ (NSArray *)xt_defaultAllSetTypes {
    return @[@(XTEmptyDataSetTypeIdle),@(XTEmptyDataSetTypeLoading), @(XTEmptyDataSetTypeNoData),
             @(XTEmptyDataSetTypeError),@(XTEmptyDataSetTypeCustom)];
}

+ (void)xt_setupGlobalEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xt_globalConfigs = [NSMutableDictionary dictionaryWithCapacity:1];
        NSArray * types = [self xt_defaultAllSetTypes];
        __block NSMutableDictionary * tmp = [NSMutableDictionary dictionaryWithCapacity:1];
        [types enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XTDataSetConfig * config = [[XTDataSetConfig alloc] init];
            if (handler) {
                handler([obj integerValue], config);
            }
            [tmp setObject:config forKey:obj];
        }];
        [xt_globalConfigs addEntriesFromDictionary:tmp];
    });
}

- (void)xt_setupEmptySetData:(void (^)(XTEmptyDataSetType type, XTDataSetConfig * config))handler {
    NSArray * types = [[self class] xt_defaultAllSetTypes];
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

- (XTDataSetConfig *)xt_configOfEmptyDataSetViewWithType:(XTEmptyDataSetType)type {
    NSMutableDictionary * configs = [self xt_emptyDataSetConfigsDictionary];
    XTDataSetConfig * config = configs[@(type)];
    if (!config) {
        if (xt_globalConfigs) {
            config = xt_globalConfigs[@(type)];
        }
    }
    
    if (!config) {
        config = [XTDataSetConfig blankIdle];
        configs[@(type)] = config;
    }
    return config;
}

- (void)xt_updateEmptySetData:(XTEmptyDataSetType)type handler:(void (^)(XTDataSetConfig * config))handler {
    NSMutableDictionary * configs = [self xt_emptyDataSetConfigsDictionary];
    XTDataSetConfig * config = configs[@(type)];
    
    if (config == nil) {
        config = [XTDataSetConfig blankIdle];
        [configs setObject:config forKey:@(type)];
    }
    
    if (xt_globalConfigs && xt_globalConfigs[@(type)]) {
        [config mergeDataFrom:xt_globalConfigs[@(type)]];
    }
    
    if (handler) {
        handler(config);
    }
    
    // 更新 dataSetView 显示的数据
    NSMutableDictionary * viewsDict = [self xt_emptyDataSetViewsDictionary];
    XTDataSetView * emptyView = (XTDataSetView *)viewsDict[@(type)];
    if (emptyView) {
        [emptyView refreshDataSet];
    }
}

- (void)xt_display:(XTEmptyDataSetType)type {
    [self xt_display:type refreshDataSet:NO];
}

- (void)xt_display:(XTEmptyDataSetType)type refreshDataSet:(BOOL)refresh {
    [self xt_hiddenEmptyDataSet];
    
    NSMutableDictionary * viewsDict = [self xt_emptyDataSetViewsDictionary];
    XTDataSetConfig * config = [self xt_configOfEmptyDataSetViewWithType:type];
    XTDataSetView * emptyView = (XTDataSetView *)viewsDict[@(type)];
    if (!emptyView) {
        emptyView = [XTDataSetView dataSetViewWithConfig:config];
        viewsDict[@(type)] = emptyView;
    }
    
    if (refresh) {
        [emptyView refreshDataSet];
    }

    [emptyView xt_dataSetViewWillAppear];
    
    [self addSubview:emptyView];
    if ([self isKindOfClass:[UIScrollView class]]) {
        [self xt_addConstraintToScrollView:emptyView edgeInset:config.edgeMarginInsets];
    }else {
        [self xt_addConstraint:emptyView edgeInset:config.edgeMarginInsets];
    }
}

- (void)xt_hiddenEmptyDataSet {
    NSDictionary * dict = [self xt_emptyDataSetViewsDictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, XTDataSetView *_Nonnull obj, BOOL * _Nonnull stop) {
        [obj xt_dataSetViewWillDisappear];
        [obj removeFromSuperview];
    }];
}

- (void)xt_clearEmptyDataSet {
    [self xt_hiddenEmptyDataSet];
    [[self xt_emptyDataSetViewsDictionary] removeAllObjects];
    [[self xt_emptyDataSetConfigsDictionary] removeAllObjects];
}

@end

