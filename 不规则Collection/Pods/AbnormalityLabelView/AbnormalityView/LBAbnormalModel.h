//
//  LBAbnormalModel.h
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LBAbnormalConfigModel;

/// 标签的数据Model,返回数据Modle需要继承这个LBAbnormalModel
@interface LBAbnormalModel : NSObject

/** 是否处于选中状态*/
@property (nonatomic,assign) BOOL selected;

/** 标签的包含信息 可能有某些信息用于网络请求参数 可后期添加*/
@property (nonatomic,strong) NSString *title;

/** 选中标签的位置*/
@property (nonatomic,strong) NSIndexPath *indexPath;

@end


/**用于做标签样式的控制*/
@interface LBAbnormalConfigModel : NSObject

///均分成几等份(默认为0-不规则布局)
@property (nonatomic,assign) NSInteger divedebyPart;
///sectionHeader类 需要header的时候需要设置
@property (nonatomic,strong) Class reusableHeaderClass;

///sectionFooter类 需要header的时候需要设置
@property (nonatomic,strong) Class reusableFooterClass;

///标签的文字 会根据keyTitle获取modley需要展示的内容
@property (nonatomic,copy) NSString *keyTitle;
@property (nonatomic,strong) UIColor *normalBorderColor;
@property (nonatomic,strong) UIColor *selectBorderColor;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,strong) UIColor *backGroundColor;
@property (nonatomic,strong) UIColor *selectBackGroundColor;

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat borderWidth;

@end

NS_ASSUME_NONNULL_END
