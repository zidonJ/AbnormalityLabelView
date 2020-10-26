//
//  LBAbnormalCell.m
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "LBAbnormalCell.h"
#import "UIView+Corner.h"

#define ssTempRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ssTempRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define LabelNormalBoaderColor ssTempRGBHex(0xFFFFFF)
#define LabelSelectBoaderColor ssTempRGBHex(0xFFB03A)
#define LabelNormalTextColor ssTempRGBHex(0xFFB03A)
#define LabelSelectTextColor ssTempRGBHex(0xFFFFFF)

@interface LBAbnormalCell () {
    
    UIColor *_normalBorderColor;
    UIColor *_selectBorderColor;
    UIColor *_normalTextColor;
    UIColor *_selectTextColor;
    UIColor *_normalBgColor;
    UIColor *_selectBgColor;
    float _radius;
    CGFloat _borderWidht;
}

@end

@implementation LBAbnormalCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark -- UI

- (void)setup {
    
    self.label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 1;
    _label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_label];
}

#pragma mark -- public

- (void)setContentText:(__kindof LBAbnormalModel *)model configModel:(LBAbnormalConfigModel *)cmodel {
    
    _label.text = [model valueForKey:cmodel.keyTitle.length?cmodel.keyTitle:@""];
    if (model.selected) {
        
        _label.textColor = cmodel.selectTextColor;
        _label.backgroundColor = cmodel.selectBackGroundColor;
    }else{
        _label.textColor = cmodel.textColor;
        _label.backgroundColor = cmodel.backGroundColor;
    }
    [_label lbcornerRadius:12.5 borderColor:nil borderWidth:0];
    [_label setNeedsLayout];
    [_label setNeedsDisplay];
    
}

@end
