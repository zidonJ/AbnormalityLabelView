//
//  MTCardLayout.h
//  不规则Collection
//
//  Created by 姜泽东 on 2018/1/31.
//  Copyright © 2018年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCardLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat spacing; //cell间距
@property (nonatomic, assign) CGSize cusItemSize; //cell的尺寸
@property (nonatomic, assign) CGFloat scale; //缩放率
@property (nonatomic, assign) UIEdgeInsets edgeInset; //边距

@end
