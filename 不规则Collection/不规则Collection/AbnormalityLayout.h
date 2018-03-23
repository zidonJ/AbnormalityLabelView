//
//  AbnormalityLayout.h
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewDelegateAlignedLayout <UICollectionViewDelegateFlowLayout>

- (void)completeLayoutHeight:(CGFloat)height;

- (BOOL)isStableHeight;

@end

@interface AbnormalityLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<UICollectionViewDelegateAlignedLayout> amLayoutDelegate;

/** 设置最大的高度限制 如果超过最大的高度就开始滚动 默认值为500*/
@property (nonatomic,assign) CGFloat maxSizeHeight;

@end


