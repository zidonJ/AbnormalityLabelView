//
//  LBAbnormalityLabelView.h
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBAbnormalModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LBAbnormalityLabelViewDelegate;

@interface LBAbnormalityLabelView : UIView


@property (weak, nonatomic) id<LBAbnormalityLabelViewDelegate> abnormalDelegate;

/// 设置了header后 可以通过此设置header高度 默认高度40
@property (nonatomic,assign) CGFloat headerHeight;
/// 设置了header后 可以通过此设置footer高度 默认高度40
@property (nonatomic,assign) CGFloat footerHeight;
/// 设置边缘
@property (nonatomic,assign) UIEdgeInsets itemInsets;
/// section inset
@property (nonatomic,assign) UIEdgeInsets sectionInset;
/// collectionView contentInset
@property (nonatomic,assign) UIEdgeInsets collectionInset;

/// 标签字体
@property (nonatomic,strong) UIFont *itemFont;

/** 是否可以多选*/
@property (nonatomic,assign) BOOL multSelect;

/** 是否可以反选 仅在单选情况下有效果*/
@property (nonatomic,assign) BOOL canOpsiteSelect;

/**
 非等分样式
 @return LBAbnormalityLabelView
 */
+ (LBAbnormalityLabelView *)createWithConfigModel:(nonnull LBAbnormalConfigModel *)configModel;

///只有一个分组的情况(传入的model可以继承自LBAbnormalModel)
- (void)reloadWithTitles:(NSArray<__kindof LBAbnormalModel *> *)titles;

///有多个分组的情况(传入的model可以继承自LBAbnormalModel)
- (void)reloadSectionsWithTitles:(NSArray<NSArray<__kindof LBAbnormalModel *> *> *)titles;

/** 设置当前的选中 单选*/
- (void)selectAtIndex:(NSIndexPath *)indexPath;

/** 取消当前的选中 */
- (void)cancelSelectAtIndex:(NSIndexPath *)indexPath;

@end

#pragma mark -- LBAbnormalityLabelViewDelegate

@protocol LBAbnormalityLabelViewDelegate<NSObject>

@optional

///当需要sectionView的时候 在这里设置header数据
- (void)headerSetting:(__kindof UICollectionReusableView *)reusableView indexPath:(NSIndexPath *)indexPath;
- (void)footerSetting:(__kindof UICollectionReusableView *)reusableView indexPath:(NSIndexPath *)indexPath;


/**
 单选

 @param model model
 */
- (void)singleSelectBack:(__kindof LBAbnormalModel *)model;

/**
 点击回调
 
 @param models 选中的选项
 */
- (void)mutilSelectBack:(NSArray<__kindof LBAbnormalModel *> *)models;

@end

NS_ASSUME_NONNULL_END
