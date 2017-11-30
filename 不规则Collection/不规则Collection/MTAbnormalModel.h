//
//  MTAbnormalModel.h
//  MTRealEstate
//
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//  不规则标签排列的Model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MTAbnormalModel : NSObject


/**
 标签的包含信息 可能有某些信息用于网络请求参数 可后期添加
 */
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,strong) UIColor *selectedColor;
/**
 具体是哪一个组的数据-用于口碑评价
 */
@property (nonatomic, assign) NSInteger sectionNum;
@end


/**
 用于做标签样式的控制
 */
@interface MTAbnormalConfigModel : NSObject

@property (nonatomic,strong) UIColor *normalBorderColor;
@property (nonatomic,strong) UIColor *selectBorderColor;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,strong) UIColor *backGroundColor;
@property (nonatomic,strong) UIColor *selectBackGroundColor;

@end
