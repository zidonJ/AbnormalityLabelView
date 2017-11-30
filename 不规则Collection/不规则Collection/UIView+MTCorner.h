//
//  UIView+MTCorner.h
//  CollectionLayoutTest
//
//  Created by 姜泽东 on 2017/10/11.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTCorner)


/**
 设置圆角

 @param radius 圆角的半径
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor *_Nullable)color borderWidth:(CGFloat)width;

/**
 设置圆角 可以避免离屏渲染
 @param corners 圆角方向
 @param radius 圆角的半径
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *_Nullable)color
             borderWidth:(CGFloat)width;


/**
 修改边框配置

 @param color 颜色
 @param width 宽度
 */
- (void)setBorderColor:(UIColor *_Nullable)color borderWidth:(CGFloat)width;


/**
 圆角图片 (UIImageView)

 @param radius 圆角半径
 */
- (UIImage *_Nullable)cornerImage:(CGFloat)radius withImage:(nonnull UIImage *)image;


/**
 设置阴影

 @param xpadding x方向大小
 @param ypadding y方向大小
 */
- (void)makeShadowOffset:(CGFloat)xpadding y:(CGFloat)ypadding opacity:(CGFloat)opacity;

@end
