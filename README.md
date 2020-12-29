# XTEmptyDataSet

[![CI Status](https://img.shields.io/travis/zt.cheng/XTEmptyDataSet.svg?style=flat)](https://travis-ci.org/zt.cheng/XTEmptyDataSet)
[![Version](https://img.shields.io/cocoapods/v/XTEmptyDataSet.svg?style=flat)](https://cocoapods.org/pods/XTEmptyDataSet)
[![License](https://img.shields.io/cocoapods/l/XTEmptyDataSet.svg?style=flat)](https://cocoapods.org/pods/XTEmptyDataSet)
[![Platform](https://img.shields.io/cocoapods/p/XTEmptyDataSet.svg?style=flat)](https://cocoapods.org/pods/XTEmptyDataSet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XTEmptyDataSet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XTEmptyDataSet'
```

## Use

Configure global Settings:

```ruby
[UIView xt_setupGlobalEmptySetData:^(XTEmptyDataSetType type, XTDataSetConfig * _Nonnull config) {
    if (type == XTEmptyDataSetTypeLoading) {
        config.emptyStyle = XTDataSetStyleIndicator;
    }else if (type == XTEmptyDataSetTypeError) {
        config.emptyStyle = XTDataSetStyleTextAction;
        config.lableText = @"网络出错";
        config.buttonCornerRadius = 4;
        config.buttonBorderColor = [UIColor blueColor];
        config.buttonBorderWidth = 1;
        
        config.buttonNormalTitleColor = [UIColor blueColor];
        config.buttonTouchHandler = ^{
            NSLog(@"重试");
        };

    }else if (type == XTEmptyDataSetTypeNoData) {
        config.emptyStyle = XTDataSetStyleTextAction;
        config.lableText = @"暂无数据";
    }
}];
```

Use on view:
```ruby
   [self xt_display:XTEmptyDataSetTypeLoading];
```

Use on tableView or colllectionView:

```ruby
  [self.tableView xt_reloadDataIfEmptyDisplay:XTEmptyDataSetTypeNoData];
```








## Author

zt.cheng, ztongcc@163.com

## License

XTEmptyDataSet is available under the MIT license. See the LICENSE file for more info.
