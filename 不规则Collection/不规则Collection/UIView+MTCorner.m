//
//  UIView+MTCorner.m
//  CollectionLayoutTest
//
//  Created by 姜泽东 on 2017/10/11.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "UIView+MTCorner.h"

#import "UIImage+ChangeImage.h"
#import <objc/runtime.h>

static char kBorderShapeLayerKey;
static char kMaskLayerKey;

@implementation UIView (MTCorner)

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)color
             borderWidth:(CGFloat)width
{
    CGRect rect = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    
    CAShapeLayer *maskLayer = objc_getAssociatedObject(self, &kMaskLayerKey);
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
        maskLayer.frame = rect;
        maskLayer.path = maskPath.CGPath;
        maskLayer.strokeColor = nil;
        self.layer.mask = maskLayer;
        objc_setAssociatedObject(self, &kMaskLayerKey, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    
    CAShapeLayer *borderLayer = (CAShapeLayer *)objc_getAssociatedObject(self, &kBorderShapeLayerKey);
    if (!borderLayer) {
        borderLayer = [CAShapeLayer layer];
        borderLayer.frame = rect;
        borderLayer.lineWidth = width;
        borderLayer.strokeColor = color.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = maskPath.CGPath;
        [self.layer addSublayer:borderLayer];
        objc_setAssociatedObject(self, &kBorderShapeLayerKey, borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setBorderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    CAShapeLayer *borderLayer = (CAShapeLayer *)objc_getAssociatedObject(self, &kBorderShapeLayerKey);
    if (borderLayer) {
        borderLayer.strokeColor = color.CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}

- (UIImage *)cornerImage:(CGFloat)radius withImage:(nonnull UIImage *)image
{
    UIImage *imageBack = [image imageWithRoundedCorner:radius];
    return imageBack;
}

- (void)makeShadowOffset:(CGFloat)xpadding y:(CGFloat)ypadding opacity:(CGFloat)opacity
{
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = CGSizeMake(xpadding, ypadding);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
