//
//  UIView+Corner.h
//  Corner
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width;

- (void)lbCornersRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width;
- (void)lbCornersRadius:(CGFloat)radius
                 corner:(UIRectCorner)corner
            borderColor:(UIColor *)color
            borderWidth:(CGFloat)width;

- (void)lbNoSaveCornersRadius:(CGFloat)radius borderColor:(UIColor *_Nullable)color borderWidth:(CGFloat)width;

- (void)makeShadowOffset:(CGFloat)xpadding y:(CGFloat)ypadding opacity:(CGFloat)opacity;

@end
