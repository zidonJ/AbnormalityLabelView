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

@end


