//
//  CollectionViewCell.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "MTAbnormalCollectionCell.h"
#import "UIView+MTCorner.h"
#import "MTSimpleFuncAble.h"

#define LabelNormalBoaderColor [UIColor blackColor]
#define LabelSelectBoaderColor [UIColor orangeColor]
#define LabelNormalTextColor [UIColor blackColor]
#define LabelSelectTextColor [UIColor orangeColor]

@interface MTAbnormalCollectionCell()

{
    UIColor *_normalColor;
    UIColor *_selectColor;
    UIColor *_normalTextColor;
    UIColor *_selectTextColor;
    float _radius;
}

@end

@implementation MTAbnormalCollectionCell

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
    _label.userInteractionEnabled = NO;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark -- public
- (void)setStyleConfig:(MTAbnormalConfigModel *)model
{
    if (!model) {
        _normalColor = LabelNormalBoaderColor;
        _selectColor = LabelSelectBoaderColor;
        _normalTextColor = LabelNormalTextColor;
        _selectTextColor = LabelSelectTextColor;
        _label.textColor = LabelNormalTextColor;
        _label.font = [UIFont systemFontOfSize:fontSize];
        [_label cornerRadius:5 borderColor:_normalColor borderWidth:1];
        _label.backgroundColor = colorWithHexString(@"E3E3E3");
    }else{
        _normalColor = model.normalBorderColor==nil?LabelNormalBoaderColor:model.normalBorderColor;
        _selectColor = model.selectBorderColor==nil?LabelSelectBoaderColor:model.selectBorderColor;
        _normalTextColor = model.textColor==nil?LabelNormalTextColor:model.textColor;
        _selectTextColor = model.selectTextColor==nil?LabelSelectTextColor:model.selectTextColor;
        _label.textColor = model.textColor == nil?LabelNormalTextColor:_normalTextColor;
        _label.font = model.fontSize<=0 ?[UIFont systemFontOfSize:fontSize]:[UIFont systemFontOfSize:model.fontSize];
        _label.backgroundColor = model.backGroundColor == nil?colorWithHexString(@"E3E3E3"):model.backGroundColor;
        [_label cornerRadius:model.radius <=0 ?5:model.radius borderColor:_normalColor borderWidth:1];
    }
}

- (void)setContentText:(__kindof MTAbnormalModel *)model
{
    _label.text = model.text;
    [self setStyleSelected:model.selected];
}

- (void)setContentText:(NSString *)title select:(BOOL)isSelected
{
    _label.text = title;
    [self setStyleSelected:isSelected];
}

#pragma mark -- private func
- (void)setStyleSelected:(BOOL)isSelected
{
    if (isSelected) {
        [_label setBorderColor:_selectColor borderWidth:1];
        _label.textColor = _selectTextColor;
    }else{
        [_label setBorderColor:_normalColor borderWidth:1];
        _label.textColor = _normalTextColor;
    }
}

@end
