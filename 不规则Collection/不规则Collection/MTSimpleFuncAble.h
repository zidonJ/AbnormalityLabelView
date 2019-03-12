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

#define ssRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ssRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

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

#define LBStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
NS_INLINE bool IsXScreen() {
    
    if (@available(iOS 11.0, *)) {
        //iOS11和11的top值不同 这里取了折中的办法
        return LBStatusBarHeight > 20;
    }else {
        return false;
    }
}


#endif /* MTSimpleFuncAble_h */
