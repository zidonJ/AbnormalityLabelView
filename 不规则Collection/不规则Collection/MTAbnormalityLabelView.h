//
//  AbnormalityLabelView.h
//  不规则Collection
//
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 MaiTian. All rights reserved.
//  根据autoLayout设计考虑 不支持frame布局

#import <UIKit/UIKit.h>
#import "MTAbnormalModel.h"

/*
 设置约束要求
 布置约束的时候需要给定一个高度 等待CollectionView布局结束的时候 本类会更新高度约束使之适应当前页面布局
 [abview mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(self.view);
 make.leading.trailing.equalTo(self.view);
 make.height.equalTo(@60);***********设置高度时尽量这样去设置
 }];
 */

@protocol MTAbnormalityLabelViewDelegate;


@interface MTAbnormalityLabelView : UIView

@property (strong, nonatomic) id<MTAbnormalityLabelViewDelegate> abnormalDelegate;
@property (nonatomic,assign,readonly) CGFloat abnormalHeight;

/**
 使用模型创建标准(等分样式)
 创建的时候可以继承MTAbnormalModel
 @param models 模型数组 模型更方便携带信息回传 多选模式的时候需要传入模型
 @param part 均分成几等份
 @param configrations 控制标签样式 可以穿nil 为默认样式
 @return MTAbnormalityLabelView
 */
+ (MTAbnormalityLabelView *)createWithCommonStyle:(NSArray<__kindof MTAbnormalModel *> *)models
                                         divedeby:(NSInteger)part
                                           config:(MTAbnormalConfigModel *)configrations;
//使用数组字符串创建 只支持单选模式
+ (MTAbnormalityLabelView *)createTitlesCommonStyle:(NSArray<NSString *> *)titles
                                           divedeby:(NSInteger)part
                                             config:(MTAbnormalConfigModel *)configrations;


/**
 使用模型数组创建
 
 @param models 模型数组 模型更方便携带信息回传 多选模式的时候需要传入模型
 @param configrations 控制标签样式 可以穿nil 为默认样式
 @return MTAbnormalityLabelView
 */
+ (MTAbnormalityLabelView *)createWithModels:(NSArray<__kindof MTAbnormalModel *> *)models
                                      config:(MTAbnormalConfigModel *)configrations;
/** 使用字符串数组创建 只支持单选模式*/
+ (MTAbnormalityLabelView *)createWithTitles:(NSArray<NSString *> *)titles
                                      config:(MTAbnormalConfigModel *)configrations;


/** 是否可以反选 仅在单选情况下有效果*/
@property (nonatomic,assign) BOOL canOpsiteSelect;

/**
 刷新数据源
 创建的时候可以继承MTAbnormalModel
 @param models 刷新数据源
 */
- (void)reloadWithData:(NSArray<__kindof MTAbnormalModel *> *)models;
- (void)reloadWithTitles:(NSArray<NSString *> *)titles;

/**
 是否可以多选
 
 @param multSelect 是否可以多选
 */
- (void)canMultipleSelect:(BOOL)multSelect;

/**
 只有一行的情况
 
 @param stable 是否稳定行高
 */
- (void)setOneLineHeightStable:(BOOL)stable;

/**
 设置默认选中
 
 @param index 默认选中的第几个标签
 */
- (void)setDefaultSelect:(NSInteger)index;


/**
 设置多选中
 [self setDefaultSelected:@1,nil]  末尾需要加nil
 类似可变数组的初始化参数赋值
 @param index NSNumber类型 ‘,’分割
 */
- (void)setDefaultSelected:(NSNumber *)indexs,...;

/** 设置当前的选中 单选*/
- (void)selectAtIndex:(NSInteger)index;

/** 取消当前的选中 */
- (void)cancelSelectAtIndex:(NSInteger)index;

@end


#pragma mark -- MTAbnormalityLabelViewDelegate
@protocol MTAbnormalityLabelViewDelegate<NSObject>

@optional

- (void)completeLayoutAbnormalHeight:(CGFloat)height;

/**
 当前选中模式
 
 @param object 当前点击 并且是选中状态
 */
- (void)clickCallBack:(MTAbnormalModel *)object index:(NSInteger)index;

/**
 传递选中模型 模型内有选中类型的BOOL值 判断是否选中
 
 @param object 当前点击
 @param array 复选模式选中数组 非复选模式为空
 */
- (void)clickCallBack:(MTAbnormalModel *)object mutilArray:(NSArray *)array index:(NSInteger)index;


/**
 传入数据源为字符串
 
 @param title 标题
 @param index NSInteger
 */
- (void)clickTitlesBack:(NSString *)title index:(NSInteger)index selected:(BOOL)selected;

@end

