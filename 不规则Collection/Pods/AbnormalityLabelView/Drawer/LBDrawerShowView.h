//
//  LBDrawerShowView.h
//  Langlib
//
//  Created by zidonj on 2018/12/17.
//  Copyright © 2018 langlib. All rights reserved.
//  这是一个抽屉容器的界面

#import <UIKit/UIKit.h>

@protocol LBDrawerShowViewDelegate;

typedef NS_ENUM(NSInteger,MTDrawerType) {
    
    LeftDrawer = 0,//左侧弹出
    RightDrawer,//右侧弹出
    BottomDrawer//底部弹出
};

@interface LBDrawerShowView : UIView

/**
 初始化

 @param type 弹出类型
 @return 返回当前对象
 */
- (instancetype)initWithDrawerType:(MTDrawerType)type;
+ (instancetype)createDrawerType:(MTDrawerType)type;


@property (nonatomic,weak) id<LBDrawerShowViewDelegate> delegate;


/**
 横屏时更新布局布局
 */
- (void)landLayout;

/**
 左右弹出
 需要一个展示的抽屉view 如果有多个view需要放在drawer上 可以自己add

 @param view view
 @param width 抽屉的宽度
 */
- (void)setNeedShowView:(__kindof UIView *)view width:(CGFloat)width;
/**
 从底部弹出
 
 @param view view
 @param height 抽屉的高度
 */
- (void)setShowBottomView:(__kindof UIView *)view height:(CGFloat)height;


/* 展示 */
- (void)show;


/** 不释放内容界面 如果需要调用一次 然后再调用消失的方法*/
- (void)needNoDestoryDisMiss;

/* 消失 会释放内容*/
- (void)disMiss;



@end


@protocol LBDrawerShowViewDelegate<NSObject>

@optional
- (void)showInScreen;

/**
 消失的回调 放在本容器的view 被强引用 需要在这里释放
 */
- (void)disAppered;

@end
