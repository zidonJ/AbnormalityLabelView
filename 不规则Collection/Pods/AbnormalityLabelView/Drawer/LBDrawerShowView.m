//
//  LBDrawerShowView.m
//  Langlib
//
//  Created by zidonj on 2018/12/17.
//  Copyright © 2018 langlib. All rights reserved.
//  这是一个抽屉容器的界面

#import "LBDrawerShowView.h"
#import <Masonry/Masonry.h>

@interface LBDrawerShowView() <UIGestureRecognizerDelegate>

@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,assign) CGFloat screenHeight;
///展示抽屉类型
@property (nonatomic,assign) MTDrawerType type;
///抽屉的内容view
@property (nonatomic,weak) UIView *showView;
///抽屉的宽度
@property (nonatomic,assign) CGFloat width;
///高度
@property (nonatomic,assign) CGFloat height;
///蒙版view
@property (nonatomic,strong) UIView *maskView;
///收回不释放抽屉
@property (nonatomic,assign) bool noDestoryed;

@end

@implementation LBDrawerShowView

#pragma mark -- init
+ (instancetype)createDrawerType:(MTDrawerType)type {
    return [[self alloc] initWithDrawerType:type];
}

- (instancetype)initWithDrawerType:(MTDrawerType)type {
    if (self = [super init]) {
        _type = type;
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        [self _prepareViews];
    }
    return self;
}

#pragma mark -- super
- (void)layoutSubviews{}

#pragma mark  -- private func
- (void)_prepareViews {
    
    UIWindow *windiow = ![UIApplication sharedApplication].keyWindow ? [UIApplication sharedApplication].windows.firstObject:[UIApplication sharedApplication].keyWindow;
    
    [windiow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(windiow);
    }];
    [windiow layoutIfNeeded];
        
    _maskView = [UIView new];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    [self addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self layoutIfNeeded];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
    tap.delegate = self;
    [_maskView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.delegate = self;
    [_maskView addGestureRecognizer:pan];
}

//手势停止的时候消失界面
- (void)panDisMiss {
    
    if (_type == RightDrawer) {
        if (CGRectGetMinX(self.showView.frame) < self.screenWidth/2) {
            
            [_showView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(@(self.screenWidth - self.width));
            }];
            [UIApplication.sharedApplication.keyWindow layoutIfNeeded];
        }else{
            [self disMiss];
        }
    }else{
        if (CGRectGetMaxX(self.showView.frame) < self.screenWidth/2) {
            [self disMiss];
        }else{
            [_showView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(@(0));
            }];
            [UIApplication.sharedApplication.keyWindow layoutIfNeeded];
        }
    }
}

#pragma mark -- public

- (void)setNeedShowView:(__kindof UIView *)view width:(CGFloat)width  {
    
    _showView = view;
    _width = width;
    
    [_showView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.type == LeftDrawer ? @(-self.screenWidth) : @(self.screenWidth*2 - self.width));
    }];

    [self layoutIfNeeded];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.delegate = self;
    [_showView addGestureRecognizer:pan];
    
}

- (void)setShowBottomView:(__kindof UIView *)view height:(CGFloat)height {
    
    _showView = view;
    _height = height;
    [self layoutIfNeeded];
    [UIView animateWithDuration:.2 delay:.1 options:7<<16 animations:^{
        self.maskView.alpha = 0.5;
        [self.showView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(0));
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show {
    
    
    [UIView animateWithDuration:.2 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
        self.maskView.alpha = 0.5;
        [self.showView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.type == LeftDrawer ? @(0) : @(self.screenWidth - self.width));
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    if (_showView && [_showView respondsToSelector:@selector(showInScreen)]) {
        [(id<LBDrawerShowViewDelegate>)_showView showInScreen];
    }
    
}

- (void)disMiss {
    
    [UIView animateWithDuration:.2 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.maskView.alpha = 0;
        if (self.type == BottomDrawer) {
            [self.showView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@(self.height));
            }];
        }else{
            [self.showView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.type == LeftDrawer ? @(-self.screenWidth) : @(self.screenWidth*2 - self.width));
            }];
        }
        [UIApplication.sharedApplication.keyWindow layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(disAppered)]) {
            [self.delegate disAppered];
        }
        if (!self.noDestoryed) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }
    }];
}

- (void)needNoDestoryDisMiss {
    
    _noDestoryed = true;
}

- (void)landLayout {
    
    if (_maskView.superview && _showView.superview) {
        [self.maskView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(self.screenWidth));
        }];
        
        [_showView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.type == LeftDrawer ? @(0):@(self.screenWidth-self.width));
        }];
    }
}

#pragma mark -- gesture
- (void)panGesture:(UIPanGestureRecognizer *)pan {

    CGPoint translatedPoint = [pan translationInView:self];
    
    CGFloat x = translatedPoint.x;

    UIWindow *windiow = [UIApplication sharedApplication].keyWindow;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            if (_type == RightDrawer && self.frame.origin.x <= 0 && x<0) {
                return;
            }
            if (_type == LeftDrawer && self.frame.origin.x >= self.screenWidth && x>0) {
                return;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if (_type == RightDrawer && self.frame.origin.x <= 0 && x<0) {
                return;
            }
            if (_type == LeftDrawer && self.frame.origin.x >= 0 && x>0) {
                return;
            }
            [_showView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.type == LeftDrawer ? @(x) : @(self.screenWidth + x - self.width));
            }];
            [windiow layoutIfNeeded];
        }
            
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:{
            
            [self panDisMiss];
            [pan setTranslation:CGPointMake(0, 0) inView:self];
        }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- UIGestureRecognizerDelegate

- (void)dealloc {
    
    NSLog(@"抽屉释放");
}

@end
