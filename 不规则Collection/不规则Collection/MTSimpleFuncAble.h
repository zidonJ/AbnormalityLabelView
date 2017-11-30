//
//  MTSimpleFuncAble.h
//  MTRealEstate
//
//  Created by 姜泽东 on 2017/11/14.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#ifndef MTSimpleFuncAble_h
#define MTSimpleFuncAble_h

#import <UIKit/UIKit.h>
#import "UIImage+ChangeImage.h"



#define MT_WSELF __weak __typeof__(self) _weakSelf = self;
#define MT_SSELF __strong __typeof__(self) self = _weakSelf;
#define MT_SSELF_NIL_RETURN MT_SSELF;if (!self) {return ;}

NS_INLINE UINib* stringGetNib(NSString *nibString) {
    
    return [UINib nibWithNibName:nibString bundle:nil];
}

NS_INLINE UIView *getXibFromString(Class className) {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(className) owner:nil options:nil] lastObject];
}

NS_INLINE UIImage *imageNamed(NSString *name){
    
    return [[UIImage imageNamed:name] renderMode:UIImageRenderingModeAlwaysOriginal];
}

NS_INLINE NSString *clearWhiteSpace(NSString *name){
    
    return [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

NS_INLINE BOOL mtIsNum(NSString *checkedNumString) {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

NS_INLINE NSString *textFormat(id value) {
    if (value == nil || [value isEqual:[NSNull null]]){
        return @"暂无信息";
    }else if ([value isKindOfClass:[NSString class]]) {
        return [(NSString *)value length] == 0 ? @"暂无信息":value;
    }else if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    return @"暂无信息";
}


NS_INLINE NSString *sfloatToInt(NSString *value) {
    if ([value containsString:@"."]) {
        NSString *last = [value componentsSeparatedByString:@"."][1];
        if ([last floatValue] == 0) {
            return [NSString stringWithFormat:@"%.f",[value floatValue]];
        }
    }
    return value;
}

NS_INLINE UIColor * colorWithHexString(NSString *color){
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}

#endif /* MTSimpleFuncAble_h */
