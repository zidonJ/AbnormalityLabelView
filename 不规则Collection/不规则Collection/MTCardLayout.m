//
//  MTCardLayout.m
//  不规则Collection
//
//  Created by 姜泽东 on 2018/1/31.
//  Copyright © 2018年 MaiTian. All rights reserved.
//

#import "MTCardLayout.h"

@interface MTCardLayout()

@end

@implementation MTCardLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//当collectionView的bounds变化时,所展现的cell的个数及显示效果可能会发生变化,此方法返回YES
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = count*(self.itemSize.width+self.spacing)-self.spacing+self.edgeInset.left+self.edgeInset.right;
    CGFloat height = self.collectionView.bounds.size.height;
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attribute =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = self.itemSize;
    
    CGFloat x = self.edgeInset.left + indexPath.item*(self.spacing+self.itemSize.width);
    CGFloat y = (self.collectionView.bounds.size.height - self.itemSize.height)/2;
    attribute.frame = CGRectMake(x, y, attribute.size.width, attribute.size.height);
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *indexPaths = [self indexPathsInRect:rect];
    
    //找到屏幕中间的位置
    CGFloat centerX =  self.collectionView.contentOffset.x + 0.5*self.collectionView.bounds.size.width;
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes* attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        // 判断可见区域和此cell的frame是否有重叠，因为indexPathsInRect返回的indexPath并不是十分准确。
        if (!CGRectIntersectsRect(rect, attribute.frame)) {
            //若不重叠则无需进行以下的步骤
            continue;
        }
        [attributes addObject:attribute];
        //计算每一个cell离屏幕中间的距离
        CGFloat offsetX = ABS(attribute.center.x - centerX);
        //这是设置一个缩放区域的阈值，当cell在此区域之外不进行缩放，改值可视具体情况进行修改。
        CGFloat space = self.itemSize.width+self.spacing;
        if (offsetX<space) {
            CGFloat scale = 1+(1-offsetX/space)*(self.scale-1);
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
            // 设置此属性是为了当cell层叠后，使得位于中间的cell总是位于最前面，若不明白可将此行注释一试便知。
            attribute.zIndex = 1;
        }
    }
    return attributes;
}

// 需要在此方法中获取默认情况下停止滚动时离屏幕中间最近的那个cell,并计算两者的距离,将此距离补到proposedContentOffset上即可
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity
{
    
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *attributes = [self layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + 0.5*self.collectionView.bounds.size.width;
    CGFloat minOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes* attribute in attributes) {
        CGFloat offsetX = attribute.center.x - centerX;
        if (ABS(offsetX) < ABS(minOffsetX)) {
            minOffsetX = offsetX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minOffsetX, proposedContentOffset.y);
}

- (NSArray *)indexPathsInRect:(CGRect)rect {
    
    NSInteger leftIndex = (rect.origin.x-self.edgeInset.left)/(self.itemSize.width+self.spacing);
    NSInteger rightIndex = (CGRectGetMaxX(rect)-self.edgeInset.left)/(self.itemSize.width+self.spacing);
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    leftIndex = leftIndex<0 ? 0 : leftIndex;
    rightIndex = rightIndex>=itemCount ? itemCount-1 : rightIndex;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger i=leftIndex; i<=rightIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end
