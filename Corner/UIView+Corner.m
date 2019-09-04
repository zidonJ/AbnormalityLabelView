//
//  UIView+MTCorner.m
//  Corner
//
//  Created by 姜泽东 on 2017/10/11.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

//
//  UIView+Corner.m
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "UIView+Corner.h"
#import <objc/runtime.h>

static char kBorderShapeLayerKey;
static char kMaskLayerKey;

@implementation UIView (Corner)

static char kBorderShapeLayerKey;
static char kMaskLayerKey;

- (void)lbcornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)lbCornersRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    
    [self setRoundedCorners:UIRectCornerAllCorners radius:radius borderColor:color borderWidth:width useCache:true];
}

- (void)lbCornersRadius:(CGFloat)radius
                 corner:(UIRectCorner)corner
            borderColor:(UIColor *)color
            borderWidth:(CGFloat)width {
    
    [self setRoundedCorners:corner radius:radius borderColor:color borderWidth:width useCache:true];
}

- (void)lbNoSaveCornersRadius:(CGFloat)radius borderColor:(UIColor *_Nullable)color borderWidth:(CGFloat)width {
    
    [self setRoundedCorners:UIRectCornerAllCorners radius:radius borderColor:color borderWidth:width useCache:false];
}

- (void)setRoundedCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderColor:(UIColor *)color
              borderWidth:(CGFloat)width
                 useCache:(BOOL)cache
{
    
    CGRect rect = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    
    CAShapeLayer *maskLayer = objc_getAssociatedObject(self, &kMaskLayerKey);
    maskLayer = maskLayer ? : [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = nil;
    self.layer.mask = maskLayer;
    objc_setAssociatedObject(self, &kMaskLayerKey, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (width > 0) {
        CAShapeLayer *borderLayer = (CAShapeLayer *)objc_getAssociatedObject(self, &kBorderShapeLayerKey);
        borderLayer = borderLayer ? : [CAShapeLayer layer];
        borderLayer.frame = rect;
        borderLayer.lineWidth = width;
        borderLayer.strokeColor = color.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = maskPath.CGPath;
        [self.layer addSublayer:borderLayer];
        objc_setAssociatedObject(self, &kBorderShapeLayerKey, borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)lbmakeShadowOffset:(CGFloat)xpadding y:(CGFloat)ypadding opacity:(CGFloat)opacity {
    
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = CGSizeMake(xpadding, ypadding);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}


@end
