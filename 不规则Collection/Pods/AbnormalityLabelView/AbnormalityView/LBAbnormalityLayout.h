//
//  LBAbnormalityLayout.h
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UICollectionViewDelegateAlignedLayout <UICollectionViewDelegateFlowLayout>

//
- (void)completeLayoutHeight:(CGFloat)height;

@end


@interface LBAbnormalityLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<UICollectionViewDelegateAlignedLayout> amLayoutDelegate;

@end

NS_ASSUME_NONNULL_END
